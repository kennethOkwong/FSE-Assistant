import 'package:flutter/material.dart';
import 'package:fse_assistant/config/theme_data.dart';
import 'package:fse_assistant/core/screens/map_screen.dart';

class InputArea extends StatefulWidget {
  const InputArea({
    super.key,
    required this.onSubmitNumberOfBaseStations,
    required this.numberOfStationsToBeAdded,
  });

  final Function(int numberOfBaseStations) onSubmitNumberOfBaseStations;
  final int numberOfStationsToBeAdded;

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  bool numberOfBaseStationsSubmitted = false;
  final TextEditingController _numberOfBaseStationController =
      TextEditingController();

  @override
  void dispose() {
    _numberOfBaseStationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numberOfBaseStationsSubmitted
              ? 'Add Base Station (${widget.numberOfStationsToBeAdded} of ${_numberOfBaseStationController.text})'
              : 'Base Stations',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          numberOfBaseStationsSubmitted
              ? 'Providing your base stations will help us recommend the closest of them during surveys.'
              : 'Please enter the number of base stations you have in the city',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        if (!numberOfBaseStationsSubmitted)
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Number of base stations',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.lightGrey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  controller: _numberOfBaseStationController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.green,
                ),
                child: IconButton(
                  onPressed: () {
                    final basestations =
                        int.tryParse(_numberOfBaseStationController.text);
                    if (basestations == null || basestations > 19) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid integer below 20'),
                        ),
                      );

                      return;
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();

                    widget.onSubmitNumberOfBaseStations(
                        int.parse(_numberOfBaseStationController.text));

                    numberOfBaseStationsSubmitted = true;
                  },
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        if (numberOfBaseStationsSubmitted)
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const MapScreen();
                    },
                  ));
                },
              ),
            ],
          ),
      ],
    );
  }
}
