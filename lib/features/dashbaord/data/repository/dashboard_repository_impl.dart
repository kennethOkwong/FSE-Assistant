import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data source/dashboard_data_source.dart';

class DashbaordRepositoryImpl implements DashboardRepository {
  final DashboardDataSource authDataSource;

  DashbaordRepositoryImpl(this.authDataSource);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    return await authDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<String?> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    return await authDataSource.register(
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<String?> verifyOTP({
    required String pinId,
    required String otp,
  }) async {
    return await authDataSource.verifyOTP(pinId: pinId, otp: otp);
  }

  @override
  Future<String?> resetPassword({required String newPassword}) async {
    return await authDataSource.resetPassword(newPassword: newPassword);
  }

  @override
  Future<String?> sendOTP(String email) async {
    return await authDataSource.sendOTP(email);
  }

  @override
  Future<UserModel?> getUser() async {
    return await authDataSource.getUser();
  }
}
