import '../../domain/models/base_station_model.dart';
import '../../domain/models/place_model.dart';

abstract class StationsDataSource {
  Future<String?> searPlaces({
    required String keyword,
  });

  Future<bool> addBaseStation({
    required String name,
    required PlaceModel address,
  });

  Future<List<BaseStationModel>?> getBaseStations();

  Future<bool> deleteBaseStations(String stationId);
  Future<bool> updateBaseStations({
    required BaseStationModel station,
    String? name,
    PlaceModel? address,
  });

  Future<String> getGoodleMapAddress(double lat, double lng);
}
