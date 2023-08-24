import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../DTO/base_station_dto.dart';

abstract class BaseStationDataSource {
  Future<Either<Failure, BaseStationDTO>> getBaseStation(String baseStationId);

  Future<Either<Failure, void>> addBaseStation(
    String name,
    double lat,
    double lng,
    String address,
  );

  Future<Either<Failure, void>> deleteBaseStation(
    String baseStationId,
  );

  Future<Either<Failure, void>> upDateBaseStation(
    String baseStationId,
    String userId,
    String name,
    String lat,
    String lng,
    String address,
  );

  Future<Either<Failure, List<BaseStationDTO>>> getBaseStations();
}
