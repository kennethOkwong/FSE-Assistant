import 'package:flutter/material.dart';

class TermsSectionWidget extends StatelessWidget {
  const TermsSectionWidget({
    super.key,
    required this.width,
    required this.header,
    required this.body,
  });

  final double width;
  final String header;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            body,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
