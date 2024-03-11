import 'dart:async';
import 'dart:convert';
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

  TextEditingController locationController = TextEditingController();

  final defaultLocation = LatLng(5.019563584179674, 7.888179508520339);
  PlaceModel? userCurrentLocation;
  PlaceModel? userLastLocation;
  Marker? locationMaker;
  PlaceModel? surveyAddress;
  List<PlaceModel> searchedAdresses = [];

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

  void setSurveyAddress(PlaceModel place) {
    surveyAddress = place;
    notifyListeners();
  }

  void addAddress(List<PlaceModel> addresses) {
    searchedAdresses.clear();
    searchedAdresses.addAll(addresses);
    notifyListeners();
  }

  Future<void> animateMap(LatLng position) async {
    final GoogleMapController controller = await mapController.future;

    controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(tilt: 50, zoom: 15, target: position),
    ));
  }

  Future<void> getUserLocation() async {
    try {
      final userLastLocation = await userLocalStorage.getUserLastLocation();
      if (userLastLocation != null) {
        setUserLastLocation(userLastLocation);
        setSurveyAddress(userLastLocation);
        await loadMapIcon(
            location: LatLng(
          userLastLocation.lat ?? 0.00,
          userLastLocation.lng ?? 0.00,
        ));
        await animateMap(LatLng(
          userLastLocation.lat ?? 0.00,
          userLastLocation.lng ?? 0.00,
        ));
      }

      final userCurrentLocation = await HelperFunctions().getUserLocation();
      if (userCurrentLocation != null) {
        setUserCurrentLocation(userCurrentLocation);
        setSurveyAddress(userCurrentLocation);

        await loadMapIcon(
            location: LatLng(
          userCurrentLocation.lat ?? 0.00,
          userCurrentLocation.lng ?? 0.00,
        ));
        await animateMap(LatLng(
          userCurrentLocation.lat ?? 0.00,
          userCurrentLocation.lng ?? 0.00,
        ));
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

    if (location != null) {
      marker = Marker(
        markerId: const MarkerId('Location'),
        position: location,
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

      setSurveyAddress(place);
      stopLoader();
    } catch (error) {
      stopLoader();
    }
  }

  Future<void> goToSearchAddress(BuildContext context) async {
    final PlaceModel? location =
        await context.push(AppRoutes.searchLocation) as PlaceModel?;

    if (location != null) {
      setSurveyAddress(location);
      await Future.delayed(const Duration(seconds: 2));
      showCustomToast('Picked Location updated', success: true);
      loadMapIcon(location: LatLng(location.lat ?? 0.00, location.lng ?? 0.00));
      animateMap(LatLng(location.lat ?? 0.00, location.lng ?? 0.00));
    }
  }

  //function to search places using google maps API
  Future<void> searchPlaces(String keyword) async {
    final responseBody = await stationsRepository.searPlaces(keyword: keyword);

    if (responseBody != null && responseBody.isNotEmpty) {
      final jsonData = jsonDecode(responseBody);
      // showCustomToast(places.toString());
      final List<dynamic> searchObjects = jsonData['results'];
      final places = searchObjects
          .map((place) => PlaceModel.fromGoogleJson(place))
          .toList();
      addAddress(places);
      notifyListeners();
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
