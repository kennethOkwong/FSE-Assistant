import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme_data.dart';
import '../../../../core/models/location.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../controllers/main_controller.dart';
import '../controllers/number_of_stations_controller.dart';
import '../widgets/bottom_buttons.dart';

class AddBaseStationsScreen extends ConsumerStatefulWidget {
  const AddBaseStationsScreen({
    super.key,
    required this.comingFromAuthScreen,
  });

  final bool comingFromAuthScreen;
  @override
  ConsumerState<AddBaseStationsScreen> createState() =>
      _AddBaseStationsScreenState();
}

class _AddBaseStationsScreenState extends ConsumerState<AddBaseStationsScreen> {
  LocationInfo? baseStationLocation;
  String? baseStationName;
  final _key = GlobalKey<FormState>();

  final baseStationNameTextEditingController = TextEditingController();

  TextEditingController baseStationAddressTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    baseStationNameTextEditingController.dispose();
    baseStationAddressTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberOfBaseStaionsState =
        ref.watch(NumberOfBaseStationsStateProvider);
    final numberOfBaseStationsMethods =
        ref.watch(NumberOfBaseStationsStateProvider.notifier);
    final baseStationStateMethods =
        ref.watch(baseStationStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title:
            widget.comingFromAuthScreen ? null : const Text('Add Base Station'),
        actions: !widget.comingFromAuthScreen
            ? null
            : [
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
                      if (widget.comingFromAuthScreen)
                        Text(
                          numberOfBaseStaionsState[
                                      'numberOfBaseStationsToBeAdded'] ==
                                  1
                              ? 'Add Base Station'
                              : 'Add Base Station (${numberOfBaseStaionsState['nthBaseStationToBeAdded']} of ${numberOfBaseStaionsState['numberOfBaseStationsToBeAdded']})',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Providing your base stations will help the app recommend the closest of them during surveys.',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.grey,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            TextFormField(
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.wifi_rounded,
                                  color: AppColors.lightGreen,
                                ),
                                hintText: 'Base station name',
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
                                if (value == null || value.trim().length < 2) {
                                  return 'Enter a valid name';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                baseStationName = newValue;
                              },
                              controller: baseStationNameTextEditingController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              controller:
                                  baseStationAddressTextEditingController,
                              validator: (value) {
                                if (value == null || value.trim().length < 2) {
                                  return 'Tab to pick a valid address';
                                }
                                return null;
                              },
                              onTap: () async {
                                final LocationInfo? value =
                                    await context.push('/map');
                                baseStationLocation = value;
                                baseStationAddressTextEditingController.text =
                                    value!.address;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ButtomButtons(onAddBaseStation: () async {
                        if (!_key.currentState!.validate()) {
                          return;
                        }

                        _key.currentState!.save();
                        final response =
                            await baseStationStateMethods.addBaseStation(
                          name: baseStationName!,
                          lat: baseStationLocation!.lat,
                          lng: baseStationLocation!.lng,
                          address: baseStationLocation!.address,
                        );
                        response.fold(
                            (l) => customSnackbar(
                                  content: l.message,
                                  context: context,
                                  success: false,
                                ), (r) {
                          customSnackbar(
                            content: 'Base Station added uccessfully',
                            context: context,
                            success: true,
                          );

                          if (numberOfBaseStationsMethods
                              .doneAddingBaseStations()) {
                            context.go('/home');
                          }
                          FocusScope.of(context).unfocus();
                          baseStationNameTextEditingController.clear();
                          baseStationAddressTextEditingController.clear();
                        });
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
