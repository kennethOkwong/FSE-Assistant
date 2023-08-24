import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../entity/base_station.dart';

abstract class BaseStationRepository {
  Future<Either<Failure, BaseStation>> getBaseStation(String baseStationId);

  Future<Either<Failure, void>> addBaseStation(
    String name,
    double lat,
    double lng,
    String address,
  );

  Future<Either<Failure, void>> deleteBaseStation(String baseStationId);

  Future<Either<Failure, void>> upDateBaseStation(
    String baseStationId,
    String userId,
    String name,
    String lat,
    String lng,
    String address,
  );

  Future<Either<Failure, List<BaseStation>>> getBaseStations();
}
