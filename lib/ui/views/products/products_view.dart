import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/categories.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/product_card.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/products/products.viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProductsViewModel(
            context.read<NavigatorService>(), context.read<AuthViewModel>(),
            idGroup: group.id),
        child:
            Consumer<ProductsViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: Text(group.name),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
                child: AnimatedBuilder(
                    animation: Listenable.merge([
                      viewModel.store.isLoading,
                      viewModel.store.errorMessage,
                      viewModel.store.products
                    ]),
                    builder: (context, child) {
                      return Skeletonizer(
                        enabled: viewModel.store.isLoading.value,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.getProportionateScreenWidth(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skeleton.keep(
                                  keep: viewModel.store.isLoadingFilter.value,
                                  child: Categories(
                                    press: (int groupId, String category,
                                        int index) {
                                      viewModel.getProductsByCategory(
                                          groupId, category, index);
                                    },
                                    idGroup: group.id,
                                    categories: viewModel.categories,
                                    selectedIndex:
                                        viewModel.selectedIndexCategory,
                                  ),
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                      childAspectRatio: 0.72,
                                    ),
                                    itemCount:
                                        viewModel.store.products.value.length,
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                        product: viewModel
                                            .store.products.value[index],
                                        press: () {
                                          viewModel.goToProductDetails(viewModel
                                              .store.products.value[index]);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      );
                    })),
          );
        }));
  }
}
