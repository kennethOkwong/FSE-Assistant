import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/models/failure.dart';
import '../../DTO/base_station_dto.dart';
import '../datasoucre.dart';

final firestore = FirebaseFirestore.instance;

class FirebaseBaseStationDataSource implements BaseStationDataSource {
  @override
  Future<Either<Failure, void>> addBaseStation(
    String name,
    double lat,
    double lng,
    String address,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    final jsonData = {
      'user_id': user!.uid,
      'name': name,
      'lat': lat,
      'lng': lng,
      'address': address
    };
    try {
      await firestore.collection('base_stations').doc().set(jsonData);
      return const Right(null);
    } catch (error) {
      return const Left(Failure(message: 'Unable to add station'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBaseStation(String baseStationId) async {
    try {
      await firestore.collection('base_stations').doc(baseStationId).delete();
      return const Right(null);
    } catch (error) {
      return const Left(Failure(message: 'Unable to add station'));
    }
  }

  @override
  Future<Either<Failure, void>> upDateBaseStation(
    String baseStationId,
    String userId,
    String name,
    String lat,
    String lng,
    String address,
  ) async {
    final jsonData = {
      'user_id': userId,
      'name': name,
      'lat': lat,
      'lng': lng,
      'address': address
    };
    try {
      await firestore
          .collection('base_stations')
          .doc(baseStationId)
          .set(jsonData);
      return const Right(null);
    } catch (error) {
      return const Left(Failure(message: 'Unable to add station'));
    }
  }

  @override
  Future<Either<Failure, BaseStationDTO>> getBaseStation(
      String baseStationId) async {
    try {
      final baseStation =
          await firestore.collection('base_stations').doc(baseStationId).get();
      final jsonData = baseStation.data();

      if (jsonData == null) {
        return const Left(Failure(message: "Unable to get station"));
      }

      return Right(
        BaseStationDTO.fromJson({
          'user_id': jsonData['user_id'],
          'id': baseStationId,
          'name': jsonData['name'],
          'lat': jsonData['lat'],
          'lng': jsonData['lng'],
          'address': jsonData['address']
        }),
      );
    } catch (error) {
      return const Left(Failure(message: 'Unable to get station'));
    }
  }

  @override
  Future<Either<Failure, List<BaseStationDTO>>> getBaseStations() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final baseStationsSnapshot =
          await firestore.collection('base_stations').get().then((value) {
        return value.docs
            .where((element) => element.data()['user_id'] == user!.uid)
            .toList();
      });

      final baseStations = baseStationsSnapshot
          .map((doc) => BaseStationDTO(
                userId: doc.data()['user_id'],
                id: doc.id,
                name: doc.data()['name'],
                lat: doc.data()['lat'],
                lng: doc.data()['lng'],
                address: doc.data()['address'],
              ))
          .toList();

      return Right(baseStations);
    } catch (error) {
      return const Left(Failure(message: 'Unable to get station'));
    }
  }
}
