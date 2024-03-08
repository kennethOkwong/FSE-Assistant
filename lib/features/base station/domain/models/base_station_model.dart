import 'package:cloud_firestore/cloud_firestore.dart';

import 'place_model.dart';

class BaseStationModel {
  String stationId = '';
  String userId = '';
  String name = '';
  PlaceModel address = PlaceModel();

  BaseStationModel(
    this.stationId,
    this.userId,
    this.name,
    this.address,
  );

  BaseStationModel.fromFirebase(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    stationId = doc.id;
    userId = doc.data()['user_id'];
    name = doc.data()['name'];
    address = PlaceModel.fromFirebase(doc);
  }
}
