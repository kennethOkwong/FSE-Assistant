import '../../domain/entity/base_station.dart';

class BaseStationDTO extends BaseStation {
  BaseStationDTO({
    required super.userId,
    required super.id,
    required super.name,
    required super.lat,
    required super.lng,
    required super.address,
  });

  factory BaseStationDTO.fromJson(Map<String, dynamic> json) {
    return BaseStationDTO(
      userId: json['user_id'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson(BaseStationDTO baseStation) {
    return {
      'user_id': baseStation.userId,
      'id': baseStation.id,
      'name': baseStation.name,
      'lat': baseStation.lat,
      'lng': baseStation.lng,
      'address': baseStation.address
    };
  }
}
