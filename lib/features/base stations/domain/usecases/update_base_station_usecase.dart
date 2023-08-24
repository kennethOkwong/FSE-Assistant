import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../repository/base_station_repo.dart';

abstract class UpDateBaseStationUseCase {
  Future<Either<Failure, void>> execute(
    String baseStationId,
    String userId,
    String name,
    String lat,
    String lng,
    String address,
  );
}

class UpDateBaseStationUseCaseImpl implements UpDateBaseStationUseCase {
  final BaseStationRepository _baseStationRepository;

  UpDateBaseStationUseCaseImpl(this._baseStationRepository);

  @override
  Future<Either<Failure, void>> execute(
    String baseStationId,
    String userId,
    String name,
    String lat,
    String lng,
    String address,
  ) async {
    return await _baseStationRepository.upDateBaseStation(
      baseStationId,
      userId,
      name,
      lat,
      lng,
      address,
    );
  }
}
