import 'package:flutter/material.dart';
import 'package:fse_assistant/core/local%20storage/user_local_data.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/features/base/base_vm.dart';
import 'package:go_router/go_router.dart';

class OnboardingVM extends BaseViewModel {
  final PageController carouselController = PageController();
  int activePage = 0;

  void changeSliderPage(int value) {
    if (activePage != value) {
      activePage = value;
      notifyListeners();
    }
  }

  void animateSlider(BuildContext context) {
    if (activePage != 2) {
      carouselController.animateToPage(
        activePage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
      );
      notifyListeners();
    } else {
      context.go(AppRoutes.auth);
      UserLocalStorage().setIsFirstLaunch();
    }
  }
}
