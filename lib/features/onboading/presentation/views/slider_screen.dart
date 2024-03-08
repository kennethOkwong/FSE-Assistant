import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/onboading/presentation/view%20models/onbaording_vm.dart';

import '../../data/slider_data.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/onboarding_carousel.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    final height = deviceHeight(context);
    final sliderHeight = width * 1.5;
    final remainingH = height - sliderHeight;
    return BaseView<OnboardingVM>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (remainingH > 80) sizexBoxH((remainingH - 80) * 0.7),
                    SizedBox(
                      width: width - 40,
                      height: sliderHeight,
                      child: PageView(
                        controller: model.carouselController,
                        children: slideList.map((slideData) {
                          return OnboardingCarousel(carouselData: slideData);
                        }).toList(),
                        onPageChanged: (value) {
                          model.changeSliderPage(value);
                        },
                      ),
                    ),
                    if (remainingH > 80) sizexBoxH((remainingH - 80) * 0.3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CarouselIndicator(
                          numberOfSlides: 3,
                          height: 80,
                          activePage: model.activePage,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            onPressed: () async {
                              model.animateSlider(context);
                            },
                            child: Text(
                              model.activePage != 2 ? 'Next' : 'Get Started',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
