import 'dart:convert';
import 'dart:developer';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../models/location.dart';
import 'credentials.dart';

class HelperFunctions {
//Function to load current location
  static Future<LocationInfo?> loadLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      return null;
    }

    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=$googleMapsAPIKey');

      final response = await http.get(url);
      final resData = jsonDecode(response.body);
      log('here');
      final address = resData['results'][1]['formatted_address'];
      log('succeded');
      return LocationInfo(
        locationData.latitude!,
        locationData.longitude!,
        address,
      );
    } catch (error) {
      log('failed');
      log(error.toString());
    }
  }
}
