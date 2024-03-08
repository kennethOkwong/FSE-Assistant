import 'package:flutter/material.dart';

import '../../../../core/app theme/app_colors.dart';

class FaqTile extends StatelessWidget {
  const FaqTile({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: AppColors.white,
      backgroundColor: AppColors.white,
      childrenPadding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      children: [
        Text(content, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
