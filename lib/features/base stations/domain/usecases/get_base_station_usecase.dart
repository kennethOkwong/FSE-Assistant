import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../entity/base_station.dart';
import '../repository/base_station_repo.dart';

abstract class GetBaseStationUseCase {
  Future<Either<Failure, BaseStation>> execute(String baseStationId);
}

class GetBaseStationUseCaseImpl implements GetBaseStationUseCase {
  final BaseStationRepository _baseStationRepository;

  GetBaseStationUseCaseImpl(this._baseStationRepository);

  @override
  Future<Either<Failure, BaseStation>> execute(String baseStationId) async {
    return await _baseStationRepository.getBaseStation(baseStationId);
  }
}
