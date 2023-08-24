import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme_data.dart';

class InputArea extends StatefulWidget {
  const InputArea({
    super.key,
    required this.numberOfBaseStationsToBeAdded,
    required this.numberOfBaseStationsLeft,
  });

  final int numberOfBaseStationsToBeAdded;
  final int numberOfBaseStationsLeft;

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.numberOfBaseStationsToBeAdded == 1
              ? 'Add Base Station'
              : 'Add Base Station (${widget.numberOfBaseStationsToBeAdded} of ${widget.numberOfBaseStationsLeft})',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Providing your base stations will help us recommend the closest of them during surveys.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            TextField(
              autocorrect: false,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.ramen_dining_rounded,
                  color: AppColors.lightGreen,
                ),
                hintText: 'Base station name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.lightGrey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autocorrect: false,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.lightGreen,
                ),
                hintText: 'Base station address ',
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.lightGrey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              onTap: () {
                context.go('/map');
              },
            ),
          ],
        ),
      ],
    );
  }
}
