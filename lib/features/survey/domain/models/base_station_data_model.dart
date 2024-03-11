import 'package:fse_assistant/features/base%20station/domain/models/base_station_model.dart';

class BaseStationDataModel {
  final BaseStationModel station;
  final double distanceFromSurveyLocation;

  BaseStationDataModel(this.station, this.distanceFromSurveyLocation);
}
