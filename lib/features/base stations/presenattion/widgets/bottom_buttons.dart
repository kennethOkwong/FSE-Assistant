import 'package:flutter/material.dart';

class ButtomButtons extends StatelessWidget {
  const ButtomButtons({super.key, required this.onAddBaseStation});

  final Function onAddBaseStation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Expanded(
        child: ElevatedButton(
          onPressed: () {
            onAddBaseStation();
          },
          child: const Text('Save Base Station'),
        ),
      ),
    );
  }
}
