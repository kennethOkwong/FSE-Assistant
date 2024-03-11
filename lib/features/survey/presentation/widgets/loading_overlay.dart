import 'package:flutter/material.dart';

import '../../../../core/app theme/app_colors.dart';
import '../../../../core/utils/widget_helpers.dart';

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.8),
          height: deviceHeight(context),
          width: deviceWidth(context),
        ),
        const Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  // strokeWidth: 50,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: AppColors.white,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Surveying...',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
