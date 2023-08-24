import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/failure.dart';
import '../../../auth/presentation/controllers/provider.dart';
import '../../domain/entity/base_station.dart';
import 'usecases_providers.dart';

final baseStationStateProvider =
    StateNotifierProvider<BaseStationNotifier, List<BaseStation>>((ref) {
  return BaseStationNotifier(ref);
});

class BaseStationNotifier extends StateNotifier<List<BaseStation>> {
  BaseStationNotifier(this.ref) : super([]) {
    getBaseStations();
  }

  final Ref ref;

  Future<Either<Failure, List<BaseStation>>> getBaseStations() async {
    final getStationsProvider = ref.read(getBaseStationsUseCaseProvider);
    final baseStations = await getStationsProvider.execute();
    baseStations.fold((l) => null, (r) => state = r);

    return Future.value(baseStations);
    // }
  }

  Future<Either<Failure, BaseStation>> getBaseStation(String baseStationId) {
    final getStationProvider = ref.read(getBaseStationUseCaseProvider);
    final baseStation = getStationProvider.execute(baseStationId);
    return baseStation;
  }

  Future<Either<Failure, void>> addBaseStation({
    required String name,
    required double lat,
    required double lng,
    required String address,
  }) async {
    final addStationProvider = ref.read(addBaseStationUseCaseProvider);
    return await addStationProvider.execute(name, lat, lng, address);
  }

  Future<Either<Failure, void>> deleteBaseStation(String baseStationId) {
    final deleteStationProvider = ref.read(deleteBaseStationUseCaseProvider);
    return deleteStationProvider.execute(baseStationId);
  }

  Future<Either<Failure, void>> updateBaseStation({
    required String baseStationId,
    required String name,
    required String lat,
    required String lng,
    required String address,
  }) async {
    Failure? failure;
    String? userId;

    final user = ref.read(authStateNotifierProvider);
    user.value!.fold(
      (l) {
        failure = l;
      },
      (r) {
        userId = r.id;
      },
    );
    if (userId == null) {
      return Future.value(Left(failure!));
    } else {
      final updateStationProvider = ref.read(updateBaseStationUseCaseProvider);
      return await updateStationProvider.execute(
        baseStationId,
        userId!,
        name,
        lat,
        lng,
        address,
      );
    }
  }
}
