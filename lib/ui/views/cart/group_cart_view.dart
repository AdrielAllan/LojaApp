import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/group_card_cart.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/need_login_view.dart';
import 'package:usanacaixaapp/ui/widgets/custom_app_bar.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/cart/group_cart_viewmodel.dart';

class GroupCartView extends StatefulWidget {
  const GroupCartView({super.key, required this.buttonMenuPress});

  final VoidCallback buttonMenuPress;

  @override
  State<GroupCartView> createState() => _GroupCartViewState();
}

class _GroupCartViewState extends State<GroupCartView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupCartViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>()),
      child: Consumer<GroupCartViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(buttonMenuPress: widget.buttonMenuPress),
          body: AnimatedBuilder(
            animation: Listenable.merge([
              viewModel.store.isLoading,
              viewModel.store.errorMessage,
              viewModel.store.groups,
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
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getProportionateScreenWidth(20),
                      vertical: SizeConfig.getProportionateScreenWidth(10)),
                  child: Skeletonizer(
                    enabled: viewModel.store.isLoading.value ||
                        viewModel.authViewModel.store.isLoading.value,
                    child: ListView.builder(
                        clipBehavior: Clip.none,
                        itemCount: viewModel.store.groups.value.length,
                        itemBuilder: (context, index) => GroupCardCart(
                              group: viewModel.store.groups.value[index],
                              press: () {
                                viewModel.goToCart(
                                    viewModel.store.groups.value[index]);
                              },
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
