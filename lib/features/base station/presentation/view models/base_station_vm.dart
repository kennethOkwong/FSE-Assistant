import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fse_assistant/core/utils/app_images.dart';
import 'package:fse_assistant/core/utils/helper_functions.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:fse_assistant/features/base%20station/domain/models/base_station_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../base/base_vm.dart';
import '../../domain/models/place_model.dart';

class BaseStationVM extends BaseViewModel {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final key = GlobalKey<FormState>();
  final baseStationNameController = TextEditingController();
  TextEditingController baseStationAddressController = TextEditingController();

  int baseStationsToAdd = 1;
  int baseStationsLeft = 1;
  bool loadingStations = true;
  List<BaseStationModel> baseStationList = [];
  List<PlaceModel> searchedAdresses = [];
  PlaceModel? pickedAddress;
  PlaceModel? userCurrentLocation;
  PlaceModel? userLastLocation;
  Marker? locationMaker;

  void setBaseStationsToAdd(int value) {
    baseStationsToAdd = value;
    notifyListeners();
  }

  void incrementBaseStationsLeft() {
    if (baseStationsLeft < baseStationsToAdd) {
      baseStationsLeft++;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    if (loadingStations != value) {
      loadingStations = value;
      notifyListeners();
    }
  }

  void addAddress(List<PlaceModel> addresses) {
    searchedAdresses.clear();
    searchedAdresses.addAll(addresses);
    notifyListeners();
  }

  void setPickedAddress(PlaceModel place) {
    pickedAddress = place;
    baseStationAddressController.text = place.address ?? '';
    notifyListeners();
  }

  void setUserCurrentLocation(PlaceModel place) {
    userCurrentLocation = place;
    notifyListeners();
  }

  void setUserLastLocation(PlaceModel place) {
    userLastLocation = place;
    notifyListeners();
  }

  void addBaseStations(List<BaseStationModel> stations) {
    baseStationList.clear();
    baseStationList.addAll(stations);
    notifyListeners();
  }

  void setLocationMaker(Marker marker) {
    locationMaker = marker;
    notifyListeners();
  }

  Future<void> getUserLocation() async {
    try {
      final userCurrentLocation = await HelperFunctions().getUserLocation();
      if (userCurrentLocation != null) {
        setUserCurrentLocation(userCurrentLocation);
        if (pickedAddress == null && searchedAdresses.isEmpty) {
          setPickedAddress(userCurrentLocation);
          showCustomToast(
              "We've auto filled address with your current location",
              success: true);
        }
        return;
      }

      final userLastLocation = await userLocalStorage.getUserLastLocation();
      if (userLastLocation != null) {
        setUserLastLocation(userLastLocation);
        if (pickedAddress == null && searchedAdresses.isEmpty) {
          setPickedAddress(userLastLocation);
          showCustomToast("We've auto filled address with your last location",
              success: true);
        }
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

    final marker = Marker(
      markerId: const MarkerId('Location'),
      position: location ?? const LatLng(5.019563584179674, 7.888179508520339),
      icon: BitmapDescriptor.fromBytes(icon),
    );

    setLocationMaker(marker);
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

  //Function to add base station
  Future<void> addBaseStation({
    required BuildContext context,
    required String name,
  }) async {
    try {
      startLoader('Adding Station...');

      final success = await stationsRepository.addBaseStation(
        name: name,
        address: pickedAddress!,
      );

      stopLoader();

      //return if success is false
      if (success == false) {
        return;
      }

      //shoe sucess message if it was adedd
      showCustomToast('Base station added', success: true);

      //increment basestations left if addition not complete
      if (baseStationsLeft != baseStationsToAdd) {
        incrementBaseStationsLeft();
        return;
      }

      //go to dashboard if user is done adding stations
      if (context.mounted) {
        context.go(AppRoutes.dashboard);
      }
    } catch (error) {
      stopLoader();
    }
  }

  //Function to get base stations
  Future<void> getBaseStations() async {
    try {
      // startLoader('Fetching Stations...');
      setLoading(true);

      final response = await stationsRepository.getBaseStations();

      setLoading(false);

      //return if response is null
      if (response == null) {
        showCustomToast('Unable to fetch stations', success: false);
        return;
      }

      // showCustomToast('Base station added', success: true);

      // // if (context.mounted) {
      // //   context.go(AppRoutes.dashboard);
      // // }
      addBaseStations(response);
    } catch (error) {
      setLoading(false);
    }
  }

  //Function to delete base station
  Future<void> deleteBaseStation({
    required BuildContext context,
    required String stationId,
  }) async {
    try {
      startLoader('Deleting Station...');

      final success = await stationsRepository.deleteBaseStations(stationId);

      stopLoader();

      //return if success is false
      if (success == false) {
        return;
      }

      //shoe sucess message if it was deleted
      showCustomToast('Base station deleted', success: true);

      //refresh stations list
      await getBaseStations();
    } catch (error) {
      stopLoader();
    }
  }

  //Function to update base station
  Future<void> updateBaseStation({
    required BuildContext context,
    String? name,
    required BaseStationModel station,
  }) async {
    try {
      startLoader('Updating Station...');

      final success = await stationsRepository.updateBaseStations(
        station: station,
        name: name,
        address: pickedAddress!,
      );

      stopLoader();

      //return if success is false
      if (success == false) {
        return;
      }

      //shoe sucess message if it was adedd
      showCustomToast('Base station updated', success: true);

      if (context.mounted) {
        context.go(AppRoutes.dashboard);
      }
      // getBaseStations().then((value) => notifyListeners());
    } catch (error) {
      stopLoader();
    }
  }
}
