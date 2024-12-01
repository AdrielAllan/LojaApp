import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/repositories/cart_repository.dart';
import 'package:usanacaixaapp/data/repositories/order_repository.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/data/utils/app_routes.dart';
import 'package:usanacaixaapp/ui/views/cart/stores/cart_store.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/obs_modal_bottom_sheet.dart';
import 'package:usanacaixaapp/ui/views/orders/stores/store.dart';
import '../base_viewmodel.dart';

class CartViewModel extends BaseViewModel {
  CartViewModel(super.navigatorService, super.authViewModel,
      {required this.group}) {
    init();
  }

  bool isChecked = false;
  bool isObsLoading = false;
  final TextEditingController obsController = TextEditingController();
  final GroupModel group;

  final CartStore store = CartStore(
    cartRepository: CartRepository(
      client: HttpClient(),
    ),
  );

  final OrderStore orderStore = OrderStore(
    orderRepository: OrderRepository(
      client: HttpClient(),
    ),
  );

  void init() {
    if (authViewModel.store.user.value != null) {
      getCart(group.id);
    }
  }

  void setChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  Future<void> getCart(int idGroup) async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await store.getCart(token!, idGroup);
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> addCartUnit(String idProduct) async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await store.addCartUnit(idProduct, token!);
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

  Future<void> removeCartUnit(String idProduct) async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await store.removeCartUnit(idProduct, token!);
        CartItemModel item =
            store.cart.value!.cart.firstWhere((item) => item.id == idProduct);
        if (item.quantity == 0) {
          getCart(group.id);
        }
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
      ExceptionService.showSuccessNotification(
          context, "Removido do carrinho!");
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteCartItem(String idProduct) async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await store.deleteCartItem(idProduct, token!);
        await getCart(group.id);
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
      ExceptionService.showSuccessNotification(
          context, "Removido do carrinho!");
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  void openFullscreenImage(String urlImage) {
    navigatorService.navigateTo(Routes.fullscreenImage, arguments: urlImage);
  }

  void openObsModal(CartItemModel item) {
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    onShowBottomSheetObs(
        context, item, () => addObs(obsController.text, item.id), this);
  }

  Future<void> addObs(String obs, String idProduct) async {
    isObsLoading = true;
    notifyListeners();
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await store.addObs(idProduct, token!, obs);
        ExceptionService.showSuccessNotification(
            context, "Observação salva com sucesso!");
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
      closeObsModal();
      isObsLoading = false;
      notifyListeners();
    }
  }

  void closeObsModal() {
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    Navigator.pop(context);
  }

  void checkOut(BuildContext context) async {
    if (isChecked) {
      await createOrder();
      if (orderStore.idOrder.value != null) {
        goToOrderDetails(orderStore.idOrder.value!);
      }
    } else {
      ExceptionService.showWarningNotification(
          context, "É preciso aceitar o termos para continuar!");
    }
  }

  Future<void> createOrder() async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        await orderStore.createOrder(token!, group.id);

        ExceptionService.showSuccessNotification(
            context, "Pedido criado com sucesso!");
      } else {
        authViewModel.store.getUserInfo();
        throw "Autentificação falhou";
      }
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  void goToOrderDetails(int idOrder) async {
    await navigatorService.navigateTo(Routes.orderDetails, arguments: idOrder);

    init();
  }
}
