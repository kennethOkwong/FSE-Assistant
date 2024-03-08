import 'package:fse_assistant/core/local%20storage/user_local_data.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base%20station/domain/repository/stations_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

class HelperFunctions {
  final stationsRepository = getIt<StationsRepository>();
  final userLocalStorage = getIt<UserLocalStorage>();

  //Function to get User Location
  Future<PlaceModel?> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(null);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.value(null);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.value(null);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final location = await Geolocator.getCurrentPosition();
    final address = await stationsRepository.getGoodleMapAddress(
      location.latitude,
      location.longitude,
    );
    final userLocation = PlaceModel(
      lat: location.latitude,
      lng: location.longitude,
      address: address,
    );
    userLocalStorage.storeUserLastLocation(userLocation);
    return userLocation;
  }
}
