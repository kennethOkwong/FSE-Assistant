import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fse_assistant/core/local%20storage/user_local_data.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:go_router/go_router.dart';

import '../../../base/base_vm.dart';
import '../widgets/email_auth_section.dart';

class AuthViewModel extends BaseViewModel {
  bool isLogin = true;
  void toggleAuthScreen() {
    isLogin = !isLogin;
    notifyListeners();
  }

  //Function to login
  Future<bool> login({
    required BuildContext context,
    required AuthDetails details,
  }) async {
    startLoader('Logging in...');
    try {
      final user = await authRepository.login(
        email: details.email,
        password: details.password,
      );

      //return if user is null
      if (user == null) {
        return false;
      }

      final userStations = await stationsRepository.getBaseStations();

      stopLoader();
      if (context.mounted) {
        (userStations == null || userStations.isEmpty)
            ? context.push(AppRoutes.noOfBaseStations)
            : context.push(AppRoutes.dashboard);
      }
      return true;
    } catch (error) {
      stopLoader();
      return false;
    }
  }

  //Function to register
  Future<void> register({
    required BuildContext context,
    required AuthDetails details,
  }) async {
    startLoader('Registering...');
    try {
      final user = await authRepository.register(
        email: details.email,
        password: details.password,
      );
      stopLoader();

      //return if user is null
      if (user == null) {
        return;
      }

      if (context.mounted) {
        context.go(AppRoutes.noOfBaseStations);
      }
    } catch (error) {
      stopLoader();
    }
  }

  //Function to sendPassword Reset code
  Future<void> sendResetCode({
    required BuildContext context,
    required String email,
  }) async {
    startLoader('Sending link...');
    try {
      await authRepository.sendPasswordREsetCode(email);
      stopLoader();
      showCustomToast('Password reset link sent', success: true);

      if (context.mounted) {
        context.pushReplacement(
          AppRoutes.verifyPasswordResetCode,
          extra: email,
        );
      }
    } catch (error) {
      stopLoader();
    }
  }

  //Function to verify password reset code
  Future<void> verifyResetCode({
    required BuildContext context,
    required String email,
    required String resetPasswordLink,
  }) async {
    String oobCode = '';
    final linkSections = resetPasswordLink.split('=');

    if (linkSections.length > 3) {
      oobCode = linkSections[2].split('&').first;
    }
    startLoader('Verifying link...');
    try {
      final userEmail = await authRepository.verifyVerifyPasswordResetCode(
        code: oobCode,
      );
      stopLoader();

      //return if user is null
      if (userEmail != email) {
        showCustomToast('Invalid password reset link', success: false);
        return;
      }

      if (context.mounted) {
        context.pushReplacement(AppRoutes.newPassword, extra: oobCode);
      }
    } catch (error) {
      stopLoader();
    }
  }

  //Function to reset password
  Future<void> resetPassword({
    required BuildContext context,
    required String code,
    required String newPassword,
  }) async {
    startLoader('Resetting Password...');
    try {
      await authRepository.resetPassword(
        code: code,
        newPassword: newPassword,
      );
      stopLoader();

      showCustomToast('Password Reset Successful', success: true);

      if (context.mounted) {
        context.go(AppRoutes.auth);
      }
    } catch (error) {
      stopLoader();
    }
  }
}
