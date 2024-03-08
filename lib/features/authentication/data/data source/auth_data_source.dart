import '../../domain/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel?> login({
    required String email,
    required String password,
  });
  Future<UserModel?> register({
    required String email,
    required String password,
  });

  Future<void> sendPasswordREsetCode(String email);

  Future<String> verifyVerifyPasswordResetCode({
    required String code,
  });

  Future<void> resetPassword({
    required String code,
    required String newPassword,
  });

  Future<void> logout();
}
