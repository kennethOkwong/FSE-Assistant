import 'package:fse_assistant/features/authentication/presentation/views/new_password_screen.dart';
import 'package:fse_assistant/features/authentication/presentation/views/verify_code_screen.dart';
import 'package:fse_assistant/features/authentication/presentation/views/reset_password_email_screen.dart';
import 'package:fse_assistant/features/base%20station/domain/models/base_station_model.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base%20station/presentation/views/add_base_station_screen.dart';
import 'package:fse_assistant/features/base%20station/presentation/views/base_stations_screem.dart';
import 'package:fse_assistant/features/base%20station/presentation/views/number_of_stations_to_add_screen.dart';
import 'package:fse_assistant/features/base%20station/presentation/views/pick_map_location_screen.dart';
import 'package:fse_assistant/features/dashbaord/presentation/views/faqs_screen.dart';
import 'package:fse_assistant/features/dashbaord/presentation/views/search_survey_location.dart';
import 'package:fse_assistant/features/dashbaord/presentation/views/terms_screen.dart';
import 'package:fse_assistant/features/survey/presentation/views/base_station_scan.dart';
import 'package:fse_assistant/features/survey/presentation/views/surveys_history_screem.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/views/auth_screen.dart';
import '../../features/dashbaord/presentation/views/dashboard_screen.dart';
import '../../features/onboading/presentation/views/page_404.dart';
import '../../features/onboading/presentation/views/slider_screen.dart';
import '../../features/onboading/presentation/views/splash_screen.dart';
import 'app_routes.dart';

final goRouter = GoRouter(
  errorBuilder: (context, state) => const Page404(),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.slider,
      builder: (context, state) => const SliderScreen(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: AppRoutes.resetPasswordEmail,
      builder: (context, state) => ResetPasswordEmailScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyPasswordResetCode,
      builder: (context, state) =>
          VerifyCodeScreen(email: state.extra as String),
    ),
    GoRoute(
      path: AppRoutes.newPassword,
      builder: (context, state) =>
          NewPasswordEmailScreen(code: state.extra as String),
    ),
    GoRoute(
      path: AppRoutes.noOfBaseStations,
      builder: (context, state) => const NoOfStationsToAddScreen(),
    ),
    GoRoute(
      path: AppRoutes.pickMapLocation,
      builder: (context, state) => PickMapLocationScreen(
        location: state.extra as PlaceModel?,
      ),
    ),
    GoRoute(
      path: AppRoutes.addBaseStation,
      builder: (context, state) => AddBaseStationsScreen(
        numberOfStationsToAdd: state.extra as int?,
      ),
    ),
    GoRoute(
      path: AppRoutes.editStation,
      builder: (context, state) => AddBaseStationsScreen(
        station: state.extra as BaseStationModel?,
      ),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.terms,
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: AppRoutes.faq,
      builder: (context, state) => const FaqsScreen(),
    ),
    GoRoute(
      path: AppRoutes.baseStations,
      builder: (context, state) => const BaseStationsScreen(),
    ),
    GoRoute(
      path: AppRoutes.surveyHistory,
      builder: (context, state) => const SurveyHistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.searchLocation,
      builder: (context, state) => const SearchLocationScreen(),
    ),
    GoRoute(
      path: AppRoutes.scanStation,
      builder: (context, state) => BaseStationsScanScreen(
        surveyLocation: state.extra as PlaceModel,
      ),
    ),
  ],
);
