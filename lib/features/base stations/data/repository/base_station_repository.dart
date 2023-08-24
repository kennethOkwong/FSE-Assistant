import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../../domain/entity/base_station.dart';
import '../../domain/repository/base_station_repo.dart';
import '../data sources/datasoucre.dart';

class BaseStationRepositoryImpl implements BaseStationRepository {
  final BaseStationDataSource _baseStationDataSource;

  BaseStationRepositoryImpl(this._baseStationDataSource);

  @override
  Future<Either<Failure, void>> addBaseStation(
    String name,
    double lat,
    double lng,
    String address,
  ) async {
    return await _baseStationDataSource.addBaseStation(
      name,
      lat,
      lng,
      address,
    );
  }

  @override
  Future<Either<Failure, void>> deleteBaseStation(String baseStationId) async {
    return await _baseStationDataSource.deleteBaseStation(baseStationId);
  }

  @override
  Future<Either<Failure, BaseStation>> getBaseStation(
      String baseStationId) async {
    return await _baseStationDataSource.getBaseStation(baseStationId);
  }

  @override
  Future<Either<Failure, List<BaseStation>>> getBaseStations() async {
    return await _baseStationDataSource.getBaseStations();
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
    return await _baseStationDataSource.upDateBaseStation(
      baseStationId,
      userId,
      name,
      lat,
      lng,
      address,
    );
  }
}
