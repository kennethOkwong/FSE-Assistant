//GetIt is used for dependency injection
//this file contains all the necessary registrations

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../features/authentication/presentation/view models/auth_view_model.dart';
import '../features/base station/data/data source/stations_data_source.dart';
import '../features/base station/data/data source/statons_firebase_data_source.dart';
import '../features/base station/data/repository/stations_repository_impl.dart';
import '../features/base station/domain/repository/stations_repository.dart';
import '../features/base station/presentation/view models/base_station_vm.dart';
import '../features/dashbaord/presentation/view models/dashboard_vm.dart';
import '../features/onboading/presentation/view models/onbaording_vm.dart';
import '../features/survey/presentation/view models/survey_vm.dart';
import 'local storage/local_storage_servcie.dart';
import 'local storage/user_local_data.dart';
import '../features/authentication/data/data source/auth_data_source.dart';
import '../features/authentication/data/data source/firebase source/auth_firebase_data_source.dart';
import '../features/base/base_vm.dart';
import '../features/authentication/data/repository/auth_repository_impl.dart';
import '../features/authentication/domain/repository/auth_repository.dart';

final getIt = GetIt.I;

void setUpLocator() {
  _setupDio();
  _registerLocalStorageServices();
  _registerRepositories();
  _registerViewModel();
}

//function to setup pretty dio interceptor
void _setupDio() {
  getIt.registerFactory(() {
    Dio dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    return dio;
  });
}

//function to register local sotorage services
void _registerLocalStorageServices() {
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  getIt.registerLazySingleton<UserLocalStorage>(() => UserLocalStorage());
}

//function to register repositories and data sources
void _registerRepositories() {
  //auth repository/data source
  getIt.registerFactory<AuthDataSource>(
    () => AuthFirebaseDataSource(getIt<Dio>(), getIt<UserLocalStorage>()),
  );
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>()),
  );

  //stations repository/data source
  getIt.registerFactory<StationsDataSource>(
    () => StationsFirebaseDataSource(getIt<Dio>(), getIt<UserLocalStorage>()),
  );
  getIt.registerFactory<StationsRepository>(
    () => StationsRepositoryImpl(getIt<StationsDataSource>()),
  );
}

//function to register view models
void _registerViewModel() {
  //View Model
  getIt.registerFactory<BaseViewModel>(() => BaseViewModel());
  getIt.registerFactory<OnboardingVM>(() => OnboardingVM());
  getIt.registerFactory<AuthViewModel>(() => AuthViewModel());
  getIt.registerFactory<BaseStationVM>(() => BaseStationVM());
  getIt.registerFactory<DashBoardVM>(() => DashBoardVM());
  getIt.registerFactory<SurveyViewModel>(() => SurveyViewModel());
}
