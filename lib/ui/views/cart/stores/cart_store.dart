import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/data/repositories/cart_repository.dart';
import 'package:usanacaixaapp/data/services/auth_service_token_storage.dart';

class CartStore {
  final ICartRepository cartRepository;
  final IAuthRepository authRepository = AuthRepository(client: HttpClient());
  final AuthServiceTokenStorage authService = AuthServiceTokenStorage();

  final ValueNotifier<CartModel?> cart = ValueNotifier<CartModel?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isObsLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAddUnitLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> idAddUnitLoading = ValueNotifier<String?>(null);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>("");

  CartStore({required this.cartRepository});

  Future<void> getCart(String token, int idGroup) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      cart.value = await cartRepository.getCart(token, idGroup);
    } catch (error) {
      errorMessage.value = error.toString();
      cart.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCart(String idProduct, String token) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      await cartRepository.addCart(idProduct, token);
    } catch (error) {
      errorMessage.value = error.toString();
      cart.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCartUnit(String idProduct, String token) async {
    isAddUnitLoading.value = true;
    idAddUnitLoading.value = idProduct;

    try {
      await authRepository.checkSession(token);
      await cartRepository.addCart(idProduct, token);

      CartItemModel item =
          cart.value!.cart.firstWhere((item) => item.id == idProduct);
      item.quantity++;

      await getCart(token, item.groupId);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      isAddUnitLoading.value = false;
      idAddUnitLoading.value = null;
    }
  }

  Future<void> removeCartUnit(String idProduct, String token) async {
    isAddUnitLoading.value = true;
    idAddUnitLoading.value = idProduct;

    try {
      await authRepository.checkSession(token);
      await cartRepository.removeCartUnit(idProduct, token);

      CartItemModel item =
          cart.value!.cart.firstWhere((item) => item.id == idProduct);
      item.quantity--;

      await getCart(token, item.groupId);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      isAddUnitLoading.value = false;
      idAddUnitLoading.value = null;
    }
  }

  Future<void> deleteCartItem(String idProduct, String token) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      await cartRepository.deleteCartItem(idProduct, token);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addObs(String idProduct, String token, String obs) async {
    isObsLoading.value = true;

    try {
      await authRepository.checkSession(token);
      await cartRepository.addObs(idProduct, token, obs);

      CartItemModel item =
          cart.value!.cart.firstWhere((item) => item.id == idProduct);
      item.obs = obs;
    } catch (error) {
      errorMessage.value = error.toString();
      cart.value = null;
      rethrow;
    } finally {
      isObsLoading.value = false;
    }
  }
}
