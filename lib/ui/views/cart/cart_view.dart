import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/cart_card.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/checkout_container.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/empty_cart.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/table_values.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/terms_modal.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/cart/cart_viewmodel.dart';

class CartView extends StatefulWidget {
  const CartView({super.key, required this.group});

  final GroupModel group;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>(),
          group: widget.group),
      child: Consumer<CartViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Carrinho"),
            centerTitle: true,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: AnimatedBuilder(
              animation: Listenable.merge([
                viewModel.store.isLoading,
                viewModel.store.errorMessage,
                viewModel.store.cart,
                viewModel.authViewModel.store.user,
                viewModel.store.isAddUnitLoading,
              ]),
              builder: (context, child) {
                return Builder(
                  builder: (context) {
                    if (viewModel.store.isLoading.value &&
                        viewModel.store.isAddUnitLoading.value == false) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (viewModel.store.cart.value == null &&
                        !viewModel.store.isLoading.value) {
                      return EmptyCartView();
                    } else {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.getProportionateScreenWidth(15)),
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  itemCount:
                                      viewModel.store.cart.value!.cart.length,
                                  itemBuilder: (context, index) => CartCard(
                                      viewmodel: viewModel,
                                      cart: viewModel
                                          .store.cart.value!.cart[index])),
                              SizedBox(
                                height: 10,
                              ),
                              TableValues(
                                price: viewModel.store.cart.value!.price,
                                salesTax: viewModel.store.cart.value!.salesTax,
                                serviceTax:
                                    viewModel.store.cart.value!.serviceTax,
                                totalToPay:
                                    viewModel.store.cart.value!.totalToPay,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.kPrimaryColor,
                                    value: viewModel.isChecked,
                                    onChanged: (bool? value) {
                                      viewModel.setChecked();
                                    },
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Eu li e concordo com todos os ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                      children: [
                                        TextSpan(
                                          text: 'termos.',
                                          style: TextStyle(
                                            color: AppColors
                                                .kPrimaryColor, // Cor do texto clicável
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              showTermsModal(context);
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CheckoutContainer(
                                viewmodel: viewModel,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }),
        );
      }),
    );
  }
}
