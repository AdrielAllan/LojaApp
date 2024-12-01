import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';

import '../base_viewmodel.dart';

class ConfigViewModel extends BaseViewModel {
  ConfigViewModel(super.navigatorService, super.authViewModel,
      {required this.goBackHome});

  final VoidCallback goBackHome;

  Future<void> logOutUser() async {
    BuildContext context = navigatorService.navigatorKey.currentContext!;
    try {
      await authViewModel.logout();
      goBackHome();
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
    } finally {
      setLoading(false);
    }
  }
}
