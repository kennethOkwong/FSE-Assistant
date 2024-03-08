import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    return await authDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserModel?> register({
    required String email,
    required String password,
  }) async {
    return await authDataSource.register(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    return await authDataSource.logout();
  }

  @override
  Future<void> resetPassword({
    required String code,
    required String newPassword,
  }) async {
    return await authDataSource.resetPassword(
      code: code,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> sendPasswordREsetCode(String email) async {
    return await authDataSource.sendPasswordREsetCode(email);
  }

  @override
  Future<String> verifyVerifyPasswordResetCode({required String code}) async {
    return await authDataSource.verifyVerifyPasswordResetCode(code: code);
  }
}
