import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/table_values.dart';
import 'package:usanacaixaapp/ui/views/orders/widgets/order_details_card.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/ui/widgets/timeline.dart';
import 'package:usanacaixaapp/ui/widgets/title_list.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/order/order_details_viewmodel.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key, required this.idOrder});

  final int idOrder;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderDetailsViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>(),
          idOrder: widget.idOrder),
      child:
          Consumer<OrderDetailsViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Pedido"),
            centerTitle: true,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: AnimatedBuilder(
            animation: Listenable.merge([
              viewModel.store.isLoading,
              viewModel.store.errorMessage,
              viewModel.store.orderDetails,
              viewModel.authViewModel.store.user
            ]),
            builder: (context, child) {
              if (viewModel.store.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(20),
                        vertical: SizeConfig.getProportionateScreenWidth(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap:
                              true, // Permite ajustar a altura ao conteúdo
                          physics:
                              NeverScrollableScrollPhysics(), // Desativa a rolagem da lista
                          itemCount: viewModel
                              .store.orderDetails.value!.products.length,
                          itemBuilder: (context, index) {
                            final produto = viewModel
                                .store.orderDetails.value!.products[index];
                            return OrderDetailsCard(
                              produto: produto,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10), // Espaço entre os itens
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TableValues(
                          price: viewModel
                              .store.orderDetails.value!.order.productsTotal,
                          salesTax: viewModel
                              .store.orderDetails.value!.order.salesTax,
                          serviceTax: viewModel
                              .store.orderDetails.value!.order.serviceTax,
                          totalToPay:
                              viewModel.store.orderDetails.value!.order.total,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        viewModel.store.orderDetails.value!.order.status ==
                                1 // "Pendente"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleList(
                                      title: "Seleciona a forma de pagamento",
                                      description: ""),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: viewModel.options.map((option) {
                                      return RadioListTile<int>(
                                        activeColor: AppColors.kPrimaryColor,
                                        title: Text(
                                            option['name']), // Nome da opção
                                        value: option[
                                            'id'], // ID associado à opção
                                        groupValue: viewModel.selectedOptionId,
                                        onChanged: (int? value) {
                                          if (value != null) {
                                            viewModel.selectedOptionId = value;
                                            viewModel
                                                .selectOptionPayment(value);
                                          }
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleList(
                                      title: "Histórico", description: ""),
                                  viewModel.store.orderDetails.value!
                                          .statusHistory.isEmpty
                                      ? Center(
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? 'assets/images/time_light.svg'
                                                    : 'assets/images/time_dark.svg',
                                                width: 150,
                                              ),
                                              Text("Nada no histórico...")
                                            ],
                                          ),
                                        )
                                      : Timeline(
                                          statusHistoryList: viewModel
                                              .store
                                              .orderDetails
                                              .value!
                                              .statusHistory),
                                ],
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        viewModel.store.orderDetails.value!.order.status ==
                                1 // "Pendente"
                            ? CustomButton(
                                isLoading: viewModel.isLoading,
                                isFixedWidth: false,
                                onPressed: () {
                                  viewModel.makePayment(context);
                                },
                                width: 1,
                                text: "Realizar pagamento",
                              )
                            : SizedBox.shrink()
                      ],
                    ),
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
