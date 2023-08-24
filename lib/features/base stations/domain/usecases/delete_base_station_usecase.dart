import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../repository/base_station_repo.dart';

abstract class DeleteBaseStationUseCase {
  Future<Either<Failure, void>> execute(
    String baseStationId,
  );
}

class DeleteBaseStationUseCaseImpl implements DeleteBaseStationUseCase {
  final BaseStationRepository _baseStationRepository;

  DeleteBaseStationUseCaseImpl(this._baseStationRepository);

  @override
  Future<Either<Failure, void>> execute(String baseStationId) async {
    return await _baseStationRepository.deleteBaseStation(baseStationId);
  }
}
