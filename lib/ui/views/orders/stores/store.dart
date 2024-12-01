import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/order_details_model.dart';
import 'package:usanacaixaapp/data/models/order_model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/data/repositories/order_repository.dart';

class OrderStore {
  final IOrderRepository orderRepository;
  final IAuthRepository authRepository = AuthRepository(client: HttpClient());

  final ValueNotifier<OrderModel?> order = ValueNotifier<OrderModel?>(null);
  final ValueNotifier<OrderDetailsModel?> orderDetails =
      ValueNotifier<OrderDetailsModel?>(null);
  final ValueNotifier<int?> idOrder = ValueNotifier<int?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>("");
  final ValueNotifier<String> successMessage = ValueNotifier<String>("");
  final ValueNotifier<String> urlToPay = ValueNotifier<String>("");

  OrderStore({required this.orderRepository});

  Future<void> getOrder(String token) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      order.value = await orderRepository.getOrder(token);
    } catch (error) {
      errorMessage.value = error.toString();
      order.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOrderDetails(String token, int idOrder) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      orderDetails.value =
          await orderRepository.getOrderDetails(token, idOrder);
    } catch (error) {
      errorMessage.value = error.toString();
      orderDetails.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(String token, int idGroup) async {
    isLoading.value = true;

    try {
      await authRepository.checkSession(token);
      idOrder.value = await orderRepository.createOrder(token, idGroup);
    } catch (error) {
      errorMessage.value = error.toString();
      idOrder.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payParceladoUsa(String token, int idOrder) async {
    try {
      await authRepository.checkSession(token);
      urlToPay.value = await orderRepository.payParceladoUsa(token, idOrder);
    } catch (error) {
      errorMessage.value = error.toString();
      urlToPay.value = "";
      rethrow;
    } finally {}
  }

  Future<void> payParcelow(String token, int idOrder) async {
    try {
      await authRepository.checkSession(token);
      urlToPay.value = await orderRepository.payParcelow(token, idOrder);
    } catch (error) {
      errorMessage.value = error.toString();
      urlToPay.value = "";
      rethrow;
    } finally {}
  }

  Future<void> payBrazilPays(String token, int idOrder) async {
    try {
      await authRepository.checkSession(token);
      urlToPay.value = await orderRepository.payBrazilPays(token, idOrder);
    } catch (error) {
      errorMessage.value = error.toString();
      urlToPay.value = "";
      rethrow;
    } finally {}
  }

  Future<void> payCredits(String token, int idOrder) async {
    try {
      await authRepository.checkSession(token);
      successMessage.value = await orderRepository.payCredits(token, idOrder);
    } catch (error) {
      errorMessage.value = error.toString();
      successMessage.value = "";
      rethrow;
    } finally {}
  }
}
