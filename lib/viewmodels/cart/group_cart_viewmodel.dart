import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/repositories/group_repository.dart';
import 'package:usanacaixaapp/data/utils/app_routes.dart';
import 'package:usanacaixaapp/ui/views/auth/login_view.dart';
import 'package:usanacaixaapp/ui/views/home/stores/group_store.dart';
import '../base_viewmodel.dart';

class GroupCartViewModel extends BaseViewModel {
  GroupCartViewModel(
    super.navigatorService,
    super.authViewModel,
  ) {
    store.groups.value = List.filled(
        7,
        GroupModel(
            id: 1,
            name: BoneMock.name,
            description: BoneMock.fullName,
            logoImage: BoneMock.address,
            openDate: BoneMock.date,
            finishDate: BoneMock.date));
    store.fetchGroups();
    if (store.groups.value.isEmpty) {
      store.groups.value = [];
    }
  }

  final GroupStore store = GroupStore(
    groupRepository: GroupRepository(
      client: HttpClient(),
    ),
  );

  void showLogin(BuildContext context) {
    onShowBottomSheetLogin(context, null);
  }

  void goToCart(GroupModel group) {
    navigatorService.navigateTo(Routes.cart, arguments: group);
  }
}
