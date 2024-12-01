import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';
import 'package:usanacaixaapp/data/models/product_details_arguments.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/ui/views/product_details/widgets/product_detail_image.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/price_card.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/product_card.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/ui/widgets/title_list.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/product_details/product_details_viewmodel.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView({
    super.key,
    required this.arguments,
  });

  final ProductDetailsArguments arguments;
  VariationModel? selectedVariation;

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    widget.selectedVariation = widget.arguments.product.variations[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedVariation == null &&
        widget.arguments.product.variations.isNotEmpty) {
      widget.selectedVariation = widget.arguments.product.variations[0];
    }
    return ChangeNotifierProvider(
      create: (context) => ProductDetailsViewModel(
          context.read<NavigatorService>(),
          context.read<AuthViewModel>(),
          idGroup: widget.arguments.idGroup,
          widget.arguments.product.variations[0].category),
      child: Consumer<ProductDetailsViewModel>(
          builder: (context, viewModel, child) {
        return AnimatedBuilder(
            animation: Listenable.merge([
              viewModel.store.isLoadingFilter,
              viewModel.store.errorMessage,
              viewModel.store.products
            ]),
            builder: (context, child) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(widget.arguments.product.variations[0].category),
                  scrolledUnderElevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductDetailImage(
                          widget: widget,
                          viewModel: viewModel,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), // Cor da sombra com opacidade
                                  spreadRadius: 8, // Expansão da sombra
                                  blurRadius: 10, // Desfoque da sombra
                                  offset: const Offset(0,
                                      0), // Deslocamento horizontal e vertical da sombra
                                ),
                              ],
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : AppColors.kDarkColor2,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.selectedVariation?.name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PriceCard(
                                  price: widget.selectedVariation?.price ?? "",
                                  promotionalPrice: widget.selectedVariation
                                          ?.promotionalPrice ??
                                      "",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                widget.arguments.product.variations[0]
                                            .variation !=
                                        ""
                                    ? customDropDownButton()
                                    : SizedBox.shrink(),
                                SizedBox(
                                  height: 50,
                                ),
                                TitleList(
                                    title: "Relacionados", description: ""),
                                Skeletonizer(
                                  enabled:
                                      viewModel.store.isLoadingFilter.value,
                                  child: SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                        childAspectRatio: 1.3,
                                      ),
                                      itemCount:
                                          viewModel.store.products.value.length,
                                      itemBuilder: (context, index) {
                                        return ProductCard(
                                          product: viewModel
                                              .store.products.value[index],
                                          press: () {
                                            viewModel.goToProductDetails(
                                                viewModel.store.products
                                                    .value[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  isLoading: viewModel.isLoading,
                                  text: "Adicionar ao carrinho",
                                  isFixedWidth: false,
                                  onPressed: () {
                                    viewModel.verifyUserState(
                                        context, widget.selectedVariation!.id);
                                  },
                                  width: 1,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            });
      }),
    );
  }

  Container customDropDownButton() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<VariationModel>(
          isExpanded: true,
          underline: SizedBox.shrink(),
          value: widget.selectedVariation,
          hint: const Text("Selecione uma variação"),
          items: widget.arguments.product.variations
              .map((VariationModel variation) {
            return DropdownMenuItem<VariationModel>(
              value: variation,
              child: Text(variation.variation),
            );
          }).toList(),
          onChanged: (VariationModel? newVariation) {
            setState(() {
              widget.selectedVariation = newVariation;
            });
          },
        ),
      ),
    );
  }
}
