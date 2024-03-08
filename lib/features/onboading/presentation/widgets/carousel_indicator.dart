import 'package:flutter/material.dart';

import '../../../../core/app theme/app_colors.dart';

class CarouselIndicator extends StatefulWidget {
  const CarouselIndicator({
    super.key,
    required this.numberOfSlides,
    required this.height,
    required this.activePage,
  });

  final int numberOfSlides;
  final double height;
  final int activePage;

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: 10,
      child: ListView.builder(
        itemCount: widget.numberOfSlides,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Burbble(fill: (index == widget.activePage) ? true : false),
              if (widget.numberOfSlides - index != 1)
                const SizedBox(
                  height: 6,
                ),
            ],
          );
        },
      ),
    );
  }
}

class Burbble extends StatelessWidget {
  const Burbble({
    super.key,
    required this.fill,
  });

  final bool fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9,
      width: 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill ? AppColors.green : null,
        border: Border.all(
          color: AppColors.lightGreen,
        ),
      ),
    );
  }
}
