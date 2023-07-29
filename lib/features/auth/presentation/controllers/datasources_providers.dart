import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/features/auth/data/data%20sources/datasource.dart';
import 'package:fse_assistant/features/auth/data/data%20sources/remote%20data%20sources/firebase_datasource.dart';

//firebase authentication datasource provider
final firebaseDataSourceProvider = Provider<DataSource>((ref) {
  return FirebaseDataSource();
});
