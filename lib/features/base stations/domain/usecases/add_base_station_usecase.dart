import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../repository/base_station_repo.dart';

abstract class AddBaseStationUseCase {
  Future<Either<Failure, void>> execute(
    String name,
    double lat,
    double lng,
    String address,
  );
}

class AddBaseStationUseCaseImpl implements AddBaseStationUseCase {
  final BaseStationRepository _baseStationRepository;

  AddBaseStationUseCaseImpl(this._baseStationRepository);
  @override
  Future<Either<Failure, void>> execute(
    String name,
    double lat,
    double lng,
    String address,
  ) async {
    return await _baseStationRepository.addBaseStation(
      name,
      lat,
      lng,
      address,
    );
  }
}
