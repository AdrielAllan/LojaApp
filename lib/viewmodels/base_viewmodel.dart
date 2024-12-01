import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';

class BaseViewModel with ChangeNotifier {
  BaseViewModel(this.navigatorService, this.authViewModel);

  final NavigatorService navigatorService;
  final AuthViewModel authViewModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
