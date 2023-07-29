import 'package:flutter/material.dart';
import 'package:fse_assistant/config/theme_data.dart';

import '../../domain/carousel.dart';

class OnboardingCarousel extends StatelessWidget {
  const OnboardingCarousel({
    super.key,
    required this.carouselData,
  });

  final CarouselData carouselData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(carouselData.imageUrl),
        const SizedBox(
          height: 80,
        ),
        Text(
          carouselData.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          carouselData.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
