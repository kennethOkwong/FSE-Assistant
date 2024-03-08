import 'package:flutter/material.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/base_station_vm.dart';

class NoOfStationsToAddScreen extends StatefulWidget {
  const NoOfStationsToAddScreen({super.key});

  @override
  State<NoOfStationsToAddScreen> createState() =>
      _NoOfStationsToAddScreenState();
}

class _NoOfStationsToAddScreenState extends State<NoOfStationsToAddScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<BaseStationVM>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  context.go(AppRoutes.dashboard);
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
                            final stations = int.parse(newValue!);
                            context.go(
                              AppRoutes.addBaseStation,
                              extra: stations, //pass no of stations as extra
                            );
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
  }
}
