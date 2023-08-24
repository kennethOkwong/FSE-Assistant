import 'package:flutter/material.dart';
import 'package:fse_assistant/core/screens/map_screen.dart';
import 'package:fse_assistant/features/base%20stations/presenattion/screens/list_base_stations_screem.dart';
import 'package:fse_assistant/features/faqs/presentation/screens/faqs_screen.dart';
import 'package:fse_assistant/features/reports/presentation/screens/reports_screen.dart';
import 'package:fse_assistant/features/terms%20&%20condition/presentation/screens/terms_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/screens/loading_screen.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/base stations/presenattion/screens/add_basestations.dart';
import '../features/base stations/presenattion/screens/request_add_basestation_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';

final goRouter = GoRouter(
  redirect: (BuildContext context, GoRouterState state) async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getBool('is_first_launch') == null) {
      return '/onbaording';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: '/onbaording',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/add_base_station/:comingFromAuthSCreen',
      builder: (context, state) => AddBaseStationsScreen(
        comingFromAuthScreen:
            bool.parse(state.pathParameters['comingFromAuthSCreen']!),
      ),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/request_add_base_station',
      builder: (context, state) => const RequestAddBaseStationsScreen(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: '/faqs',
      builder: (context, state) => const FaqsScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/list_base_stations',
      builder: (context, state) => const ListBaseStationsScreen(),
    ),
  ],
);
