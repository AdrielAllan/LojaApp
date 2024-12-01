import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/data/repositories/product_repository.dart';
import 'package:usanacaixaapp/data/services/auth_service_token_storage.dart';

class ProductStore {
  final IProductRepository productRepository;
  final IAuthRepository authRepository = AuthRepository(client: HttpClient());
  final AuthServiceTokenStorage authService = AuthServiceTokenStorage();

  final ValueNotifier<List<ProductModel>> products =
      ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoadingFilter = ValueNotifier<bool>(false);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>("");

  ProductStore({required this.productRepository});

  Future<void> fetchGroups(int groupId) async {
    isLoading.value = true;

    try {
      products.value = await productRepository.getProducts(groupId);
    } catch (error) {
      errorMessage.value = error.toString();
      products.value = [];
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProductsbyCategory(int groupId, String category) async {
    isLoading.value = true;
    isLoadingFilter.value = true;

    try {
      products.value =
          await productRepository.getProductsbyCategory(groupId, category);
    } catch (error) {
      errorMessage.value = error.toString();
      products.value = [];
      rethrow;
    } finally {
      isLoading.value = false;
      isLoadingFilter.value = false;
    }
  }
}
