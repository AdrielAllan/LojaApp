import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/repositories/order_repository.dart';
import 'package:usanacaixaapp/data/utils/app_routes.dart';
import 'package:usanacaixaapp/ui/views/auth/login_view.dart';
import 'package:usanacaixaapp/ui/views/orders/stores/store.dart';
import '../base_viewmodel.dart';

class OrderViewModel extends BaseViewModel {
  OrderViewModel(
    super.navigatorService,
    super.authViewModel,
  ) {
    init();
  }

  void init() async {
    if (authViewModel.store.user.value != null) {
      String? token = authViewModel.store.token.value;
      await store.getOrder(token!);
    }
  }

  final OrderStore store = OrderStore(
    orderRepository: OrderRepository(
      client: HttpClient(),
    ),
  );

  void showLogin(BuildContext context) async {
    await onShowBottomSheetLogin(context, null);

    if (authViewModel.store.user.value != null) {
      init();
    }
  }

  void goToOrderDetails(int idOrder) async {
    await navigatorService.navigateTo(Routes.orderDetails, arguments: idOrder);

    init();
  }

  Map<String, dynamic> getActionForStatus(String status, int idOrder) {
    if (status != "Pendente") {
      return {
        'text': "Ver Detalhes",
        'action': () {
          goToOrderDetails(idOrder);
        },
      };
    } else {
      return {
        'text': "Finalizar Pedido",
        'action': () {
          goToOrderDetails(idOrder);
        },
      };
    }
  }
}
