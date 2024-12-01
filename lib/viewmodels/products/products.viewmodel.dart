import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';
import 'package:usanacaixaapp/data/models/product_details_arguments.dart';
import 'package:usanacaixaapp/data/repositories/product_repository.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/data/utils/app_routes.dart';
import 'package:usanacaixaapp/data/utils/get_categories.dart';
import 'package:usanacaixaapp/ui/views/products/stores/product_store.dart';

import '../base_viewmodel.dart';

class ProductsViewModel extends BaseViewModel {
  ProductsViewModel(super.navigatorService, super.authViewModel,
      {required this.idGroup}) {
    init();
  }

  final int idGroup;
  final List<String> categories = [];
  int selectedIndexCategory = 0;

  final ProductStore store = ProductStore(
    productRepository: ProductRepository(
      client: HttpClient(),
    ),
  );

  Future<void> init() async {
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    try {
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
      categories.addAll([
        BoneMock.name,
        BoneMock.name,
        BoneMock.name,
        BoneMock.name,
        BoneMock.name
      ]);
      await store.fetchGroups(idGroup);
      categories.clear();
      categories.addAll(getCategories(store.products.value));
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      if (store.products.value.isEmpty) {
        categories.clear();
      }
      setLoading(false);
    }
  }

  Future<void> getProductsByCategory(
      int idGroup, String category, int index) async {
    selectedIndexCategory = index;
    String categoryFilter = removeDiacritics(category);
    BuildContext context = navigatorService.navigatorKey.currentContext!;

    try {
      if (category == "Todos") {
        init();
      } else {
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
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  void goToProductDetails(ProductModel product) {
    final ProductDetailsArguments arguments =
        ProductDetailsArguments(idGroup: idGroup, product: product);
    navigatorService.navigateTo(Routes.productDetails, arguments: arguments);
  }
}
