import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';
import 'package:usanacaixaapp/data/models/product_details_arguments.dart';
import 'package:usanacaixaapp/data/repositories/cart_repository.dart';
import 'package:usanacaixaapp/data/repositories/product_repository.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/data/utils/app_routes.dart';
import 'package:usanacaixaapp/ui/views/auth/login_view.dart';
import 'package:usanacaixaapp/ui/views/cart/stores/cart_store.dart';
import 'package:usanacaixaapp/ui/views/products/stores/product_store.dart';

import '../base_viewmodel.dart';

class ProductDetailsViewModel extends BaseViewModel {
  ProductDetailsViewModel(
      super.navigatorService, super.authViewModel, this.category,
      {required this.idGroup}) {
    getProductsByCategory(idGroup, category);
  }

  final int idGroup;
  final String category;

  final ProductStore store = ProductStore(
    productRepository: ProductRepository(
      client: HttpClient(),
    ),
  );

  final CartStore cartStore = CartStore(
    cartRepository: CartRepository(
      client: HttpClient(),
    ),
  );

  Future<void> getProductsByCategory(int idGroup, String category) async {
    String categoryFilter = removeDiacritics(category);
    store.products.value = List.filled(
        7,
        ProductModel(photo: BoneMock.address, variations: [
          VariationModel(
              id: "1",
              name: BoneMock.name,
              price: BoneMock.name,
              category: BoneMock.name,
              variation: BoneMock.name)
        ]));
    await store.getProductsbyCategory(idGroup, categoryFilter);
    if (store.products.value.isEmpty) {
      store.products.value = [];
    }
  }

  void goToProductDetails(ProductModel product) {
    ProductDetailsArguments arguments =
        ProductDetailsArguments(idGroup: idGroup, product: product);
    navigatorService.navigateTo(Routes.productDetails, arguments: arguments);
  }

  void openFullscreenImage(String urlImage) {
    navigatorService.navigateTo(Routes.fullscreenImage, arguments: urlImage);
  }

  Future<void> addCart(String idProduct) async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await cartStore.addCart(idProduct, token!);
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
      ExceptionService.showSuccessNotification(
          context, "Adicionado ao carrinho!");
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  void verifyUserState(BuildContext context, String idProduct) {
    if (authViewModel.store.user.value == null) {
      showLogin(context);
    } else {
      addCart(idProduct);
    }
  }

  void showLogin(BuildContext context) {
    onShowBottomSheetLogin(context, null);
  }
}
