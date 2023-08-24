import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../entity/base_station.dart';
import '../repository/base_station_repo.dart';

abstract class GetBaseStationsUseCase {
  Future<Either<Failure, List<BaseStation>>> execute();
}

class GetBaseStationsUseCaseImpl implements GetBaseStationsUseCase {
  final BaseStationRepository _baseStationRepository;

  GetBaseStationsUseCaseImpl(this._baseStationRepository);

  @override
  Future<Either<Failure, List<BaseStation>>> execute() async {
    return await _baseStationRepository.getBaseStations();
  }
}
