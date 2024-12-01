import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  String? warningMessage;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void setSuccess(String message) {
    successMessage = message;
    notifyListeners();
  }

  void setWarning(String message) {
    warningMessage = message;
    notifyListeners();
  }

  void clearMessages() {
    errorMessage = null;
    successMessage = null;
    notifyListeners();
  }
}
