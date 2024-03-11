import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/survey/domain/models/base_station_data_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_images.dart';
import '../../../base/base_vm.dart';

class SurveyViewModel extends BaseViewModel {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  bool loading = true;
  List surveyHistory = [];
  List<BaseStationDataModel> surveyData = [];
  Set<Marker> mapMarkers = {};
  Set<Polyline> polylines = {};

  setLoading(bool value) {
    if (value != loading) {
      loading = value;
      notifyListeners();
    }
  }

  addBaseStationData(BaseStationDataModel data) {
    surveyData.add(data);
    notifyListeners();
  }

  addMarker(Marker marker) {
    mapMarkers.add(marker);
    notifyListeners();
  }

  addPolyline(Polyline polyline) {
    polylines.add(polyline);
    notifyListeners();
  }

  //function to load map icon
  Future<void> loadMapIcon({
    required LatLng location,
    String? imagePath,
    String? markerId,
  }) async {
    ByteData data = await rootBundle.load(imagePath ?? AppImages.mapIcon);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    final icon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();

    final marker = Marker(
      markerId: MarkerId(markerId ?? 'Location'),
      position: location,
      icon: BitmapDescriptor.fromBytes(icon),
    );

    addMarker(marker);
  }

  Future<void> animateMap(LatLng start, LatLng stop) async {
    final GoogleMapController controller = await mapController.future;

    LatLngBounds boundsLatLag;
    if (start.latitude > stop.latitude && start.longitude > stop.longitude) {
      boundsLatLag = LatLngBounds(southwest: stop, northeast: start);
    } else if (start.longitude > stop.longitude) {
      boundsLatLag = LatLngBounds(
          southwest: LatLng(start.latitude, stop.longitude),
          northeast: LatLng(stop.latitude, start.longitude));
    } else if (start.latitude > stop.latitude) {
      boundsLatLag = LatLngBounds(
          southwest: LatLng(stop.latitude, start.longitude),
          northeast: LatLng(start.latitude, stop.longitude));
    } else {
      boundsLatLag = LatLngBounds(southwest: start, northeast: stop);
    }

    controller.moveCamera(CameraUpdate.newLatLngBounds(
      boundsLatLag,
      30,
    ));
  }

  Future<void> surveyLocation(PlaceModel location) async {
    try {
      // await Future.delayed(const Duration(seconds: 5));
      final stations = await stationsRepository.getBaseStations();

      if (stations == null || stations.isEmpty) {
        setLoading(false);
        showCustomToast('You have no base stations', success: false);
        return;
      }

      final surveyLocation = LatLng(location.lat ?? 0.00, location.lng ?? 0.00);
      await loadMapIcon(location: surveyLocation);

      int polylineAndMarkerId = 1;
      double longestDistance = 0;
      LatLng farthestStation = LatLng(0.00, 0.00);
      for (var station in stations) {
        //calculate distances and add station data
        final stationLocation = LatLng(
          station.address.lat ?? 0.00,
          station.address.lng ?? 0.00,
        );
        final distanceAway = Geolocator.distanceBetween(
          surveyLocation.latitude,
          surveyLocation.longitude,
          stationLocation.latitude,
          stationLocation.longitude,
        );
        final data = BaseStationDataModel(station, distanceAway);
        addBaseStationData(data);

        //check if it's the farthest station
        if (longestDistance < distanceAway) {
          longestDistance = distanceAway;
          farthestStation = stationLocation;
        }

        //load marker
        await loadMapIcon(
          location: stationLocation,
          imagePath: AppImages.station,
          markerId: polylineAndMarkerId.toString(),
        );

        //draw polyline
        final polyline = Polyline(
          polylineId: PolylineId(polylineAndMarkerId.toString()),
          points: [surveyLocation, stationLocation],
          color: AppColors.green,
          width: 5,
        );
        addPolyline(polyline);
        polylineAndMarkerId++;
      }

      setLoading(false);

      //adjust map boundary
      animateMap(surveyLocation, farthestStation);
    } catch (error) {
      log(error.toString());
      setLoading(false);
    }
  }
}
