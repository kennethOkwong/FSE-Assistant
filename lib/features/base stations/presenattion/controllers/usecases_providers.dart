import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/features/base%20stations/domain/usecases/add_base_station_usecase.dart';
import 'package:fse_assistant/features/base%20stations/domain/usecases/delete_base_station_usecase.dart';
import 'package:fse_assistant/features/base%20stations/domain/usecases/get_base_station_usecase.dart';
import 'package:fse_assistant/features/base%20stations/domain/usecases/update_base_station_usecase.dart';

import 'repository_provider.dart';
import '../../domain/usecases/get_base_stations_usecase.dart';

final addBaseStationUseCaseProvider = Provider((ref) {
  return AddBaseStationUseCaseImpl(ref.read(baseStationRepositoryProvider));
});

final deleteBaseStationUseCaseProvider = Provider((ref) {
  return DeleteBaseStationUseCaseImpl(ref.read(baseStationRepositoryProvider));
});

final getBaseStationUseCaseProvider = Provider((ref) {
  return GetBaseStationUseCaseImpl(ref.read(baseStationRepositoryProvider));
});

final getBaseStationsUseCaseProvider = Provider((ref) {
  return GetBaseStationsUseCaseImpl(ref.read(baseStationRepositoryProvider));
});

final updateBaseStationUseCaseProvider = Provider((ref) {
  return UpDateBaseStationUseCaseImpl(ref.read(baseStationRepositoryProvider));
});
