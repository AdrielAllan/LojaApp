import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/need_login_view.dart';
import 'package:usanacaixaapp/ui/views/home/widgets/credit_card.dart';
import 'package:usanacaixaapp/ui/views/orders/widgets/order_card.dart';
import 'package:usanacaixaapp/ui/views/orders/widgets/rectangular_card.dart';
import 'package:usanacaixaapp/ui/widgets/custom_app_bar.dart';
import 'package:usanacaixaapp/ui/widgets/title_list.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/order/order_viewmodel.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.buttonMenuPress});

  final VoidCallback buttonMenuPress;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>()),
      child: Consumer<OrderViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(buttonMenuPress: widget.buttonMenuPress),
          body: AnimatedBuilder(
            animation: Listenable.merge([
              viewModel.store.isLoading,
              viewModel.store.errorMessage,
              viewModel.store.order,
              viewModel.authViewModel.store.user
            ]),
            builder: (context, child) {
              if (viewModel.authViewModel.store.user.value == null) {
                return NeedLoginView(
                  showLogin: () {
                    viewModel.showLogin(context);
                  },
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(20),
                        vertical: SizeConfig.getProportionateScreenWidth(10)),
                    child: Skeletonizer(
                        enabled: viewModel.store.isLoading.value ||
                            viewModel.authViewModel.store.isLoading.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skeleton.leaf(
                              child: CreditCard(
                                  behance: viewModel
                                      .authViewModel.store.user.value!.balance),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TitleList(
                                title: "Resumo de suas compras",
                                description: ""),
                            Skeleton.leaf(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RectangularCard(
                                      title: "Solicitações criadas",
                                      value: viewModel.store.order.value == null
                                          ? "0"
                                          : viewModel.store.order.value!
                                              .ordersSummary.totalOrders
                                              .toString(),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFf5365c),
                                          Color(0xFFB52844),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  RectangularCard(
                                      title: "Solicitações Pendentes",
                                      value: viewModel.store.order.value == null
                                          ? "0"
                                          : viewModel.store.order.value!
                                              .ordersSummary.incompleteOrders
                                              .toString(),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF8965e0),
                                          Color(0xFF6A4EAD),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Skeleton.leaf(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RectangularCard(
                                      title: "Solicitações a Confirmar",
                                      value: viewModel.store.order.value == null
                                          ? "0"
                                          : viewModel.store.order.value!
                                              .ordersSummary.awaitingOrders
                                              .toString(),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF11cdef),
                                          Color(0xFF1171ef),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  RectangularCard(
                                      title: "Solicitações Pagas",
                                      value: viewModel.store.order.value == null
                                          ? "0"
                                          : viewModel.store.order.value!
                                              .ordersSummary.payedOrders
                                              .toString(),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF2dce89),
                                          Color(0xFF219966),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TitleList(
                                title: "Confira todas as suas compras",
                                description: ""),
                            viewModel.store.order.value?.orders.isEmpty ?? false
                                ? Center(
                                    child: Column(
                                      children: [
                                        Skeleton.replace(
                                          child: SvgPicture.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? 'assets/images/pack_light.svg'
                                                : 'assets/images/pack_dark.svg',
                                            width: 150,
                                          ),
                                        ),
                                        Text("Nenhum pedido ainda...")
                                      ],
                                    ),
                                  )
                                : Skeleton.replace(
                                    replacement: Skeleton.leaf(
                                      child: Container(
                                        width: double.infinity,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red),
                                      ),
                                    ),
                                    child: ListView.separated(
                                      shrinkWrap:
                                          true, // Permite ajustar a altura ao conteúdo
                                      physics:
                                          NeverScrollableScrollPhysics(), // Desativa a rolagem da lista
                                      itemCount: viewModel.store.order.value
                                              ?.orders.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        final order = viewModel
                                            .store.order.value!.orders[index];
                                        final actionData =
                                            viewModel.getActionForStatus(
                                                order.status, order.id);
                                        return OrderCard(
                                          grupo: order.group.storeName,
                                          valor: order.total,
                                          status: order.status,
                                          dataSoliticitacao: order.createdAt,
                                          statusBackgroundColor:
                                              order.statusBackgroundColor,
                                          statusTextColor:
                                              order.statusTextColor,
                                          actionData: actionData,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              height:
                                                  10), // Espaço entre os itens
                                    ),
                                  )
                          ],
                        )),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
