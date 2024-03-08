import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base/base_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/helper_functions.dart';

class DashBoardVM extends BaseViewModel {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final defaultLocation = LatLng(5.019563584179674, 7.888179508520339);
  PlaceModel? userCurrentLocation;
  PlaceModel? userLastLocation;
  Marker? locationMaker;
  PlaceModel? pickedAddress;

  void setUserCurrentLocation(PlaceModel place) {
    userCurrentLocation = place;
    notifyListeners();
  }

  void setUserLastLocation(PlaceModel place) {
    userLastLocation = place;
    notifyListeners();
  }

  void setLocationMaker(Marker marker) {
    locationMaker = marker;
    notifyListeners();
  }

  void setPickedAddress(PlaceModel place) {
    pickedAddress = place;
    notifyListeners();
  }

  Future<void> getUserLocation() async {
    try {
      final userLastLocation = await userLocalStorage.getUserLastLocation();
      if (userLastLocation != null) {
        setUserLastLocation(userLastLocation);
      }

      final userCurrentLocation = await HelperFunctions().getUserLocation();
      if (userCurrentLocation != null) {
        setUserCurrentLocation(userCurrentLocation);
        return;
      }
    } catch (error) {
      //
    }
  }

  //function to load map icon
  Future<void> loadMapIcon({LatLng? location}) async {
    ByteData data = await rootBundle.load(AppImages.mapIcon);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    final icon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();

    late Marker marker;

    if (userCurrentLocation != null) {
      marker = Marker(
        markerId: const MarkerId('Location'),
        position: LatLng(
          userCurrentLocation?.lat ?? 0.00,
          userCurrentLocation?.lng ?? 0.00,
        ),
        icon: BitmapDescriptor.fromBytes(icon),
      );
      setLocationMaker(marker);
      return;
    }

    if (userLastLocation != null) {
      marker = Marker(
        markerId: const MarkerId('Location'),
        position: LatLng(
          userLastLocation?.lat ?? 0.00,
          userLastLocation?.lng ?? 0.00,
        ),
        icon: BitmapDescriptor.fromBytes(icon),
      );
      setLocationMaker(marker);
      return;
    }

    marker = Marker(
      markerId: const MarkerId('Location'),
      position: defaultLocation,
      icon: BitmapDescriptor.fromBytes(icon),
    );
    setLocationMaker(marker);
    return;
  }

  Future<void> getMapAddress(LatLng location) async {
    try {
      loadMapIcon(location: location);
      startLoader('Getting address...');
      final address = await stationsRepository.getGoodleMapAddress(
        location.latitude,
        location.longitude,
      );
      final place = PlaceModel(
        lat: location.latitude,
        lng: location.longitude,
        address: address,
      );

      setPickedAddress(place);
      stopLoader();
    } catch (error) {
      stopLoader();
    }
  }

  Future<void> logout(BuildContext context) async {
    authRepository.logout();
    context.go(AppRoutes.auth);
  }

  Future<void> emailSupport() async {
    final url = Uri.parse(
      'mailto:cadenny2021@gmail.com?subject=Feedback%20from%20FSE%20Assistant%20user&body=Hi%20Team,',
    );

    if (!await launchUrl(url)) {
      showCustomToast('Unable to open email app', success: false);
    }
  }
}
