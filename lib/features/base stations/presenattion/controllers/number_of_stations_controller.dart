import 'package:flutter_riverpod/flutter_riverpod.dart';

final NumberOfBaseStationsStateProvider =
    StateNotifierProvider<NumberOfBaseStationsStateNotifier, Map<String, int>>(
        (ref) {
  return NumberOfBaseStationsStateNotifier();
});

class NumberOfBaseStationsStateNotifier
    extends StateNotifier<Map<String, int>> {
  NumberOfBaseStationsStateNotifier()
      : super({
          'numberOfBaseStationsToBeAdded': 0,
          'numberOfBaseStationsAdded': 0,
        });

  void setNumberOfBaseStationsToBeAdded(int value) {
    state = {
      'numberOfBaseStationsToBeAdded': value,
      'nthBaseStationToBeAdded': 1,
    };
  }

  bool doneAddingBaseStations() {
    if (state['numberOfBaseStationsToBeAdded'] !=
        state['nthBaseStationToBeAdded']) {
      state = {
        'numberOfBaseStationsToBeAdded':
            state['numberOfBaseStationsToBeAdded']!,
        'nthBaseStationToBeAdded': state['nthBaseStationToBeAdded']! + 1,
      };
      return false;
    }
    return true;
  }
}
