import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/local storage/local_storage_servcie.dart';
import '../../core/local storage/user_local_data.dart';
import '../authentication/domain/repository/auth_repository.dart';
import '../base station/domain/repository/stations_repository.dart';

final getIt = GetIt.I;

class BaseViewModel extends ChangeNotifier {
  String errorMessage = '';
  String loadingText = '';
  bool isLoading = false;
  LocalStorageService storageService = getIt<LocalStorageService>();
  AuthRepository authRepository = getIt<AuthRepository>();
  StationsRepository stationsRepository = getIt<StationsRepository>();

  UserLocalStorage userLocalStorage = getIt<UserLocalStorage>();

  void setErrorMessage(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = '';
    notifyListeners();
  }

  void setLoadingText(String text) {
    loadingText = text;
    notifyListeners();
  }

  void clearLoadingText() {
    loadingText = '';
    notifyListeners();
  }

  void startLoader(String? text) {
    if (!isLoading) {
      isLoading = true;
      setLoadingText(text ?? '');
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      clearLoadingText();
      notifyListeners();
    }
  }
}
