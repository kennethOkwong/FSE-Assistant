import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data sources/remote data source/firebase_data_source.dart';

final firebaseBaseStationDataSourceProvider = Provider((ref) {
  return FirebaseBaseStationDataSource();
});
