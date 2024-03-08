import 'package:cloud_firestore/cloud_firestore.dart';

enum PlaceType { pickup, dropoff }

class PlaceModel {
  String? placeId;
  String? name;
  String? address;
  String? iconUrl;
  double? lat;
  double? lng;

  PlaceModel({
    this.placeId,
    this.name,
    this.address,
    this.iconUrl,
    this.lat,
    this.lng,
  });

  PlaceModel.fromGoogleJson(Map<String, dynamic> json) {
    placeId = json['place_id'] ?? '';
    name = json['name'] ?? '';
    address = json['formatted_address'] ?? '';
    iconUrl = json['icon'] ?? '';
    lat = json['geometry']['location']['lat'] ?? 0.00;
    lng = json['geometry']['location']['lng'] ?? 0.00;
  }

  PlaceModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    lat = doc.data()['lat'];
    lng = doc.data()['lng'];
    address = doc.data()['address'];
  }

  PlaceModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
      "address": address,
      "name": name,
    };
  }
}
