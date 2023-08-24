import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme_data.dart';
import '../../../../core/screens/loading_screen.dart';
import '../controllers/main_controller.dart';
import '../controllers/number_of_stations_controller.dart';

class RequestAddBaseStationsScreen extends ConsumerStatefulWidget {
  const RequestAddBaseStationsScreen({super.key});

  @override
  ConsumerState<RequestAddBaseStationsScreen> createState() =>
      _RequestAddBaseStationsScreenState();
}

class _RequestAddBaseStationsScreenState
    extends ConsumerState<RequestAddBaseStationsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final numberOfBaseStaionsMethod =
        ref.watch(NumberOfBaseStationsStateProvider.notifier);
    final baseStationMethods = ref.watch(baseStationStateProvider.notifier);
    return FutureBuilder(
      future: baseStationMethods.getBaseStations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        return snapshot.data!.fold(
          (l) {
            return const HomeScreen();
          },
          (r) {
            if (r.isNotEmpty) {
              return const HomeScreen();
            }

            return Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      context.go('/home');
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
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      'Base Stations',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please enter the number of base stations you have in the city',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Form(
                          key: _formKey,
                          child: Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Number of base stations',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.lightGrey),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    int.tryParse(value) == null ||
                                    int.parse(value) < 1 ||
                                    int.parse(value) > 10) {
                                  return 'Enter a number between 1 and 10';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                numberOfBaseStaionsMethod
                                    .setNumberOfBaseStationsToBeAdded(
                                        int.parse(newValue!));
                                context.go('/add_base_station/${true}');
                              },
                            ),
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
