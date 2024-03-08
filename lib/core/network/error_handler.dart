import 'dart:convert';
import 'package:dio/dio.dart';
import '../utils/snack_message.dart';

// This handles the errors in the app i made use of DioError
void handleError(dynamic error) {
  var errorString = error.response.toString();
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.cancel:
        showCustomToast("Request to API server was cancelled");
        break;
      case DioExceptionType.connectionTimeout:
        showCustomToast("Connection timeout with API server");
        break;
      case DioExceptionType.unknown:
        showCustomToast(
            "An error occured, please make sure you have an internet access");
        break;
      case DioExceptionType.receiveTimeout:
        showCustomToast("Receive timeout in connection with API server");
        break;

      case DioExceptionType.badResponse:
        // showCustomToast(error.message);
        final errorMessage = error.response?.data["message"];
        if (errorMessage != null) {
          showCustomToast(errorMessage);
        } else {
          showCustomToast(error.response?.data)["errors"];
        }
        break;
      case DioExceptionType.sendTimeout:
        showCustomToast("Send timeout in connection with API server");
        break;
      default:
        showCustomToast("Something went wrong");
        break;
    }
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];
    showCustomToast(nameJson);
    throw nameJson;
  }
}
