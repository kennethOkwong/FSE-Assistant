import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/app_images.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetIt getIt = GetIt.I;

  _splash() async {
    await Future.delayed(const Duration(seconds: 2), () {});

    // final userToken = await userLocalStorage.getToken();
    final userData = await userLocalStorage.getUser();
    final isFirstLaunch = await userLocalStorage.getIsFirstLaunch();
    if (mounted) {
      //go to slider if user is lauching the app for the first time
      if (isFirstLaunch) {
        context.go(AppRoutes.slider);
        return;
      }

      //go go auth screen if user is not logged in
      if (userData == null) {
        context.go(AppRoutes.auth);
        return;
      }

      //go to dashboard if all above fails
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    _splash();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            AppImages.appLogo,
            width: width * 0.3,
            height: width * 0.3,
          ),
        ),
      ),
    );
  }
}
