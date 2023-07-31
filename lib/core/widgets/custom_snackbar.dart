import 'package:flutter/material.dart';

ScaffoldFeatureController customSnackbar({
  required BuildContext context,
  required String content,
  required bool success,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: success
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.onErrorContainer,
    ),
  );
}
