import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';

import '../../../../core/app theme/app_colors.dart';
import '../../domain/slider_model.dart';

class OnboardingCarousel extends StatelessWidget {
  const OnboardingCarousel({
    super.key,
    required this.carouselData,
  });

  final CarouselData carouselData;

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          carouselData.imageUrl,
          width: width * 0.8,
          height: width * 0.8,
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          carouselData.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: width * 0.037,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          carouselData.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
                fontSize: width * 0.038,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
