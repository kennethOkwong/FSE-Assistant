import 'package:flutter/material.dart';
import 'package:fse_assistant/config/theme_data.dart';
import 'package:fse_assistant/features/base%20stations/presenattion/widgets/bottom_buttons.dart';
import 'package:fse_assistant/features/base%20stations/presenattion/widgets/input_area.dart';

import '../../../home/presentation/screens/home_screen.dart';

class AddBaseStations extends StatefulWidget {
  const AddBaseStations({super.key});

  @override
  State<AddBaseStations> createState() => _AddBaseStationsState();
}

class _AddBaseStationsState extends State<AddBaseStations> {
  bool _numberOfBaseStationsSubmitted = false;
  late final int _numberOfBaseStations;
  int _numberOfBaseStationsLeft = 1;

  void _addBaseStation() {
    //logic to add base station

    //logic to prompt adding next station or going to home page

    if (_numberOfBaseStations > _numberOfBaseStationsLeft) {
      setState(() {
        _numberOfBaseStationsLeft++;
      });
      return;
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return const HomeScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ));
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InputArea(
                        onSubmitNumberOfBaseStations: (numberOfBaseStations) {
                          setState(() {
                            _numberOfBaseStations = numberOfBaseStations;
                            _numberOfBaseStationsSubmitted = true;
                          });
                        },
                        numberOfStationsToBeAdded: _numberOfBaseStationsLeft,
                      ),
                      const Spacer(),
                      if (_numberOfBaseStationsSubmitted)
                        ButtomButtons(onAddBaseStation: () {
                          _addBaseStation();
                        }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
