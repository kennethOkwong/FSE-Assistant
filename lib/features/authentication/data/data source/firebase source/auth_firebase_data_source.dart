import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fse_assistant/core/local%20storage/local_storage_servcie.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';

import 'package:get_it/get_it.dart';

import '../../../../../core/local storage/user_local_data.dart';
import '../../../../../core/network/error_handler.dart';
import '../../../domain/models/user_model.dart';
import '../auth_data_source.dart';

final getIt = GetIt.I;

class AuthFirebaseDataSource implements AuthDataSource {
  final UserLocalStorage userLocalStorage;
  final Dio dio;
  final firebase = FirebaseAuth.instance;

  AuthFirebaseDataSource(this.dio, this.userLocalStorage);

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredetials = await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredetials.user == null) {
        showCustomToast('Unable to login', success: false);
        return null;
      }

      final user = UserModel.fromFirebase(userCredetials.user!);
      return user;
    } on FirebaseAuthException catch (error) {
      showCustomToast(error.message ?? 'Unable to login', success: false);
      rethrow;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<UserModel?> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredetials = await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredetials.user == null) {
        showCustomToast('Unable to register', success: false);
        return null;
      }

      final user = UserModel.fromFirebase(userCredetials.user!);
      return user;
    } on FirebaseAuthException catch (error) {
      showCustomToast(error.message ?? 'Unable to register', success: false);
      rethrow;
    } on DioException catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordREsetCode(String email) async {
    try {
      await firebase.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (error) {
      showCustomToast(error.message ?? 'Unable send code', success: false);
      rethrow;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<String> verifyVerifyPasswordResetCode({required String code}) async {
    try {
      final userEmail = await firebase.verifyPasswordResetCode(code);

      log(userEmail);
      return userEmail;
    } on FirebaseAuthException catch (error) {
      showCustomToast(error.message ?? 'Unable to verify link', success: false);
      rethrow;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({
    required String code,
    required String newPassword,
  }) async {
    try {
      await firebase.confirmPasswordReset(code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (error) {
      showCustomToast(error.message ?? 'Unable to reset password',
          success: false);
      rethrow;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await LocalStorageService().deleteAllItems();
    await firebase.signOut();
  }
}
