import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fse_assistant/core/network/url_path.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';

import 'package:get_it/get_it.dart';
import '../../../../core/local storage/user_local_data.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/network_config.dart';
import '../../../../core/network/secret_keys.dart';
import '../../domain/models/base_station_model.dart';
import 'stations_data_source.dart';

final getIt = GetIt.I;

class StationsFirebaseDataSource implements StationsDataSource {
  final UserLocalStorage userLocalStorage;
  final Dio dio;
  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  StationsFirebaseDataSource(this.dio, this.userLocalStorage);

  @override
  Future<String?> searPlaces({required String keyword}) async {
    try {
      final query = {
        "query": keyword,
        "key": googleMapsAPIKey,
      };

      var response = await dio.get(
        "${NetworkConfig.googelMapsBaseUrl}${UrlPath.googleMapsSearchPlaceAPI}",
        queryParameters: query,
      );

      return jsonEncode(response.data);
    } on DioException catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<bool> addBaseStation({
    required String name,
    required PlaceModel address,
  }) async {
    final user = await UserLocalStorage().getUser();

    if (user == null) {
      showCustomToast('No user found. Please Logout and Log back in again',
          success: false);
      return false;
    }

    final jsonData = {
      'user_id': user.userId,
      'name': name,
      'lat': address.lat,
      'lng': address.lng,
      'address': address.address,
    };
    try {
      await firestore.collection('base_stations').doc().set(jsonData);

      return true;
    } catch (error) {
      log(error.toString());
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<List<BaseStationModel>?> getBaseStations() async {
    try {
      final user = await UserLocalStorage().getUser();

      if (user == null) {
        showCustomToast(
          'No user found. Please Logout and Log back in again',
          success: false,
        );
        return null;
      }

      final baseStationsSnapshot =
          await firestore.collection('base_stations').get().then((value) {
        return value.docs
            .where((element) => element.data()['user_id'] == user.userId)
            .toList();
      });

      final baseStations = baseStationsSnapshot
          .map((doc) => BaseStationModel.fromFirebase(doc))
          .toList();

      return baseStations;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<bool> deleteBaseStations(String stationId) async {
    try {
      await firestore.collection('base_stations').doc(stationId).delete();

      return true;
    } catch (error) {
      handleError(error);
      return false;
    }
  }

  @override
  Future<bool> updateBaseStations({
    required BaseStationModel station,
    String? name,
    PlaceModel? address,
  }) async {
    final user = await UserLocalStorage().getUser();

    if (user == null) {
      showCustomToast('No user found. Please Logout and Log back in again',
          success: false);
      return false;
    }

    final jsonData = {
      'user_id': user.userId,
      'name': name ?? station.name,
      'lat': address?.lat ?? station.address.lat,
      'lng': address?.lng ?? station.address.lng,
      'address': address?.address ?? station.address.address,
    };
    try {
      await firestore
          .collection('base_stations')
          .doc(station.stationId)
          .set(jsonData);

      return true;
    } catch (error) {
      handleError(error);
      return false;
    }
  }

  @override
  Future<String> getGoodleMapAddress(double lat, double lng) async {
    try {
      var response = await dio.get(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapsAPIKey');

      return jsonEncode(response.data['results'][1]['formatted_address']);
    } on DioException catch (error) {
      handleError(error);
      rethrow;
    }
  }
}
