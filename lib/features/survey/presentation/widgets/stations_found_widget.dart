import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../../../../core/utils/widget_helpers.dart';

class BaseStationsFoundWidget extends StatelessWidget {
  const BaseStationsFoundWidget({
    super.key,
    required this.onTap,
    required this.numberOfStations,
  });

  final VoidCallback onTap;
  final int numberOfStations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        sizexBoxH(20),
        Text(
          'Base Stations Found',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '$numberOfStations base stations were found nearest to your location',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        sizexBoxH(20),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {
                  onTap();
                },
                child: const Text(
                  'Full Report',
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
