import '../../domain/models/user_model.dart';

abstract class DashboardDataSource {
  Future<void> login({
    required String email,
    required String password,
  });
  Future<String?> register({
    required String email,
    required String phone,
    required String password,
  });

  Future<String?> sendOTP(String email);
  Future<String?> verifyOTP({
    required String pinId,
    required String otp,
  });

  Future<String?> resetPassword({required String newPassword});

  Future<UserModel?> getUser();
}
