import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/repositories/order_repository.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/ui/views/orders/stores/store.dart';
import 'package:usanacaixaapp/ui/widgets/confirmation_dialog.dart';
import 'package:usanacaixaapp/ui/widgets/web_view.dart';
import '../base_viewmodel.dart';

class OrderDetailsViewModel extends BaseViewModel {
  OrderDetailsViewModel(super.navigatorService, super.authViewModel,
      {required this.idOrder}) {
    init();
  }

  final int idOrder;
  int? selectedOptionId;
  final List<Map<String, dynamic>> options = [
    {'id': 1, 'name': 'Pagar com Créditos da carteira'},
    {'id': 2, 'name': 'Pagar com BrazilPays'},
    {'id': 3, 'name': 'Pagar com Parcelado USA'},
    {'id': 4, 'name': 'Pagar com Parcelow'},
  ];

  void init() async {
    if (authViewModel.store.user.value != null) {
      String? token = authViewModel.store.token.value;
      await store.getOrderDetails(token!, idOrder);
    }
  }

  final OrderStore store = OrderStore(
    orderRepository: OrderRepository(
      client: HttpClient(),
    ),
  );

  void selectOptionPayment(int selected) {
    selectedOptionId = selected;
    notifyListeners();
  }

  void makePayment(BuildContext context) {
    if (selectedOptionId != null) {
      ConfirmationDialog.show(
          context: context,
          title: "Confirmação de opção de pagamento",
          message: "Tem certeza que deseja fazer o pagamento?",
          onConfirm: () {
            getPayment();
          });
    } else {
      ExceptionService.showWarningNotification(
          context, "É necessário selecionar opção de pagaemento");
    }
  }

  Future<void> getPayment() async {
    setLoading(true);
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    String? token = authViewModel.store.token.value;
    try {
      if (token != "" || token != null) {
        switch (selectedOptionId) {
          case 1:
            // Pagamento com Créditos da carteira
            await store.payCredits(token!, idOrder);
            ExceptionService.showSuccessNotification(
                context, store.successMessage.value);
            authViewModel.store.getUserInfo();
            init();
            break;
          case 2:
            // Pagamento com BrazilPays
            await store.payBrazilPays(token!, idOrder);
            goToPayment();
            break;
          case 3:
            // Pagamento com Parcelado USA
            await store.payParceladoUsa(token!, idOrder);
            goToPayment();
            break;
          case 4:
            // Pagamento com Parcelow
            await store.payParcelow(token!, idOrder);
            goToPayment();
            break;
          default:
            throw "Opção de pagamento inválida.";
        }
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

  void goToPayment() async {
    BuildContext context = navigatorService.navigatorKey.currentContext!;

    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebView(
        paymentUrl: store.urlToPay.value,
      ),
    ));

    init();
  }
}
