import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/domain/models/user_model.dart';
import 'table_constant.dart';
import 'local_storage_servcie.dart';

final getIt = GetIt.I;

class UserLocalStorage {
  LocalStorageService storageService = getIt<LocalStorageService>();

  Future<void> storeUser(Map<String, dynamic>? userData) async {
    await storageService.storeItem(
      key: DbTable.userData,
      value: jsonEncode(userData),
    );
  }

  Future<UserModel?> getUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    } else {
      return UserModel.fromFirebase(user);
    }
  }

  Future<void> storeToken(String? token) async {
    storageService.storeItem(
      key: DbTable.token,
      value: jsonEncode(token),
    );
  }

  Future<String?> getToken() async {
    final data = await storageService.readItem(DbTable.token);
    if (data == null || data == "null") {
      return null;
    } else {
      return data;
    }
  }

  Future<void> setIsFirstLaunch() async {
    storageService.storeItem(
      key: DbTable.firstLaunch,
      value: 'firstLaunch',
    );
  }

  Future<bool> getIsFirstLaunch() async {
    final data = await storageService.readItem(DbTable.firstLaunch);
    if (data == null || data == "null") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> storeUserLastLocation(PlaceModel userLocation) async {
    final json = userLocation.toJson();
    await storageService.storeItem(
      key: DbTable.userLastLocation,
      value: jsonEncode(json),
    );
  }

  Future<PlaceModel?> getUserLastLocation() async {
    final data = await storageService.readItem(DbTable.userLastLocation);
    if (data == null || data == "null") {
      return null;
    } else {
      return PlaceModel.fromJson(jsonDecode(data));
    }
  }

  logout() async {
    await storageService.deleteAllItems();
  }
}
