import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_sources_providers.dart';
import '../../data/repository/base_station_repository.dart';

final baseStationRepositoryProvider = Provider((ref) {
  return BaseStationRepositoryImpl(
      ref.read(firebaseBaseStationDataSourceProvider));
});
