import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/home/widgets/credit_card.dart';
import 'package:usanacaixaapp/ui/views/home/widgets/group_card.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/search_field.dart';
import 'package:usanacaixaapp/ui/views/home/widgets/skeleton_group.dart';
import 'package:usanacaixaapp/ui/widgets/custom_app_bar.dart';
import 'package:usanacaixaapp/ui/widgets/title_list.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/home/home_viewModel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.buttonMenuPress});

  final VoidCallback buttonMenuPress;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>()),
      child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(buttonMenuPress: buttonMenuPress),
          body: SafeArea(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                viewModel.store.isLoading,
                viewModel.store.errorMessage,
                viewModel.store.groups,
                viewModel.authViewModel.store.user
              ]),
              builder: (context, child) {
                return Skeletonizer(
                  enabled: viewModel.store.isLoading.value ||
                      viewModel.authViewModel.store.isLoading.value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(20)),
                    child: CustomScrollView(
                      clipBehavior: Clip.none,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    SizeConfig.getProportionateScreenWidth(20),
                              ),
                              /*Skeleton.unite(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SearchField(),
                                    ),
                                  ],
                                ),
                              ),*/
                              SizedBox(
                                height:
                                    SizeConfig.getProportionateScreenWidth(20),
                              ),
                              Skeleton.leaf(
                                  child: CreditCard(
                                behance:
                                    viewModel.authViewModel.store.user.value !=
                                            null
                                        ? viewModel.authViewModel.store.user
                                            .value!.balance
                                        : "0",
                              )),
                              SizedBox(
                                height:
                                    SizeConfig.getProportionateScreenWidth(20),
                              ),
                              TitleList(
                                title: "shopping_group".tr(),
                                description:
                                    "check_open_shops_for_shopping_group".tr(),
                              ),
                              SizedBox(
                                height:
                                    SizeConfig.getProportionateScreenWidth(10),
                              ),
                            ],
                          ),
                        ),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Skeleton.replace(
                                replacement: const SkeletonGroup(),
                                child: GroupCard(
                                  group: viewModel.store.groups.value[index],
                                  press: () {
                                    viewModel.goToProducts(
                                        viewModel.store.groups.value[index]);
                                  },
                                ),
                              );
                            },
                            childCount: viewModel.store.groups.value.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
