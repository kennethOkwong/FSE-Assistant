import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import '../../../../../core/local storage/user_local_data.dart';
import '../../../../../core/network/error_handler.dart';
import '../../../../../core/network/network_config.dart';
import '../../../../../core/network/url_path.dart';
import '../../../domain/models/user_model.dart';
import '../dashboard_data_source.dart';

final getIt = GetIt.I;

class DashboardRemoteDataSource implements DashboardDataSource {
  final UserLocalStorage userLocalStorage;
  final Dio dio;

  DashboardRemoteDataSource(this.dio, this.userLocalStorage);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final requestBody = {
        'email': email,
        'password': password,
      };

      final response = await dio.post(
        '${Config.baseUrl}${UrlPath.login}',
        data: requestBody,
        options: Options(
          followRedirects: true,
          headers: {"Accept": "application/json"},
        ),
      );

      final String token = response.data['token'];
      userLocalStorage.storeToken(token);
    } on DioException catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final requestBody = {
        'email': email,
        'phone_number': phone,
        'password': password,
      };

      final response = await dio.post(
        '${Config.baseUrl}${UrlPath.register}',
        data: requestBody,
        options: Options(
          followRedirects: true,
          headers: {"Accept": "application/json"},
        ),
      );

      return response.data.toString();
    } on DioException catch (error) {
      handleError(error);
      return null;
    }
  }

  @override
  Future<String?> sendOTP(String email) async {
    try {
      final param = {
        'email': email,
      };

      final response = await dio.get(
        '${Config.baseUrl}${UrlPath.sendOTP}',
        queryParameters: param,
        options: Options(
          followRedirects: true,
          headers: {"Accept": "application/json"},
        ),
      );

      return response.data['pin_id'];
    } on DioException catch (error) {
      handleError(error);
      return null;
    }
  }

  @override
  Future<String?> verifyOTP({
    required String pinId,
    required String otp,
  }) async {
    try {
      final requestBody = {
        'pin': otp,
        'pin_id': pinId,
      };

      final response = await dio.post(
        '${Config.baseUrl}${UrlPath.verifyOtp}',
        data: requestBody,
        options: Options(
          followRedirects: true,
          headers: {"Accept": "application/json"},
        ),
      );

      return jsonEncode(response.data);
    } on DioException catch (error) {
      handleError(error);
      return null;
    }
  }

  @override
  Future<String?> resetPassword({required String newPassword}) async {
    try {
      final requestBody = {
        'new_password': newPassword,
      };

      final userToken = await userLocalStorage.getToken();

      final response = await dio.post(
        '${Config.baseUrl}${UrlPath.resetPassword}',
        data: requestBody,
        options: Options(
          followRedirects: true,
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $userToken",
          },
        ),
      );

      return response.data.toString();
    } on DioException catch (error) {
      handleError(error);
      return null;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userToken = await userLocalStorage.getToken();

      final response = await dio.get(
        '${Config.baseUrl}${UrlPath.userProfile}',
        options: Options(
          followRedirects: true,
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $userToken",
          },
        ),
      );

      final user = UserModel.fromJson(response.data);

      await userLocalStorage.storeUser(response.data);

      return user;
    } on DioException catch (error) {
      handleError(error);
      rethrow;
    }
  }
}
