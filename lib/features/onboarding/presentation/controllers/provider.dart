import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/onboarding_carousel.dart';
import '../../domain/carousel.dart';

//Carousel data provider
final onboardingScreensProvider = Provider<List<CarouselData>>((ref) {
  return slideList;
});

//carousel state notifier
class CarouselStateNotifier extends StateNotifier<int> {
  CarouselStateNotifier() : super(0);

  void changeCarouselPage(int value) {
    state = value;
  }

  Future<bool> shouldgetStarted(PageController carouselController) async {
    if (state != 2) {
      carouselController.animateToPage(
        state + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
      );
      return false;
    }

    return true;
  }
}

final carouselStateProvider =
    StateNotifierProvider<CarouselStateNotifier, int>((ref) {
  return CarouselStateNotifier();
});
