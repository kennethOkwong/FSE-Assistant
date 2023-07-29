import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/provider.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/onboarding_carousel.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _carouselController = PageController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final carouselData = ref.watch(onboardingScreensProvider);
    final carouselState = ref.watch(carouselStateProvider);
    final carouselStateMethods = ref.watch(carouselStateProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 600,
              child: PageView(
                controller: _carouselController,
                children: carouselData.map((slideData) {
                  return OnboardingCarousel(carouselData: slideData);
                }).toList(),
                onPageChanged: (value) {
                  carouselStateMethods.changeCarouselPage(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselIndicator(
                  numberOfSlides: 3,
                  height: 80,
                  activePage: carouselState,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      final shouldGetStarted = await carouselStateMethods
                          .shouldgetStarted(_carouselController);

                      if (shouldGetStarted) {
                        setState(() {
                          _isLoading = true;
                        });

                        final sharedPreference =
                            await SharedPreferences.getInstance();
                        sharedPreference.setBool('is_first_launch', false);

                        context.go('/auth');
                      }
                    },
                    child: _isLoading
                        ? const Text('Loading...')
                        : Text(
                            carouselState != 2 ? 'Next' : 'Get Started',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
