import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';

import '../../domain/models/base_station_model.dart';
import '../../domain/repository/stations_repository.dart';
import '../data source/stations_data_source.dart';

class StationsRepositoryImpl implements StationsRepository {
  final StationsDataSource stationsDataSource;

  StationsRepositoryImpl(this.stationsDataSource);

  @override
  Future<String?> searPlaces({required String keyword}) async {
    return await stationsDataSource.searPlaces(keyword: keyword);
  }

  @override
  Future<bool> addBaseStation(
      {required String name, required PlaceModel address}) async {
    return await stationsDataSource.addBaseStation(
      name: name,
      address: address,
    );
  }

  @override
  Future<List<BaseStationModel>?> getBaseStations() async {
    return await stationsDataSource.getBaseStations();
  }

  @override
  Future<bool> deleteBaseStations(String stationId) async {
    return await stationsDataSource.deleteBaseStations(stationId);
  }

  @override
  Future<bool> updateBaseStations({
    required BaseStationModel station,
    String? name,
    PlaceModel? address,
  }) async {
    return await stationsDataSource.updateBaseStations(
      station: station,
      name: name,
      address: address,
    );
  }

  @override
  Future<String> getGoodleMapAddress(double lat, double lng) async {
    return await stationsDataSource.getGoodleMapAddress(lat, lng);
  }
}
