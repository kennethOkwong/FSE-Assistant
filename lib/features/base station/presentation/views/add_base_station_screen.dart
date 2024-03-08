import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base%20station/domain/models/base_station_model.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/base_station_vm.dart';
import '../widgets/location_widget.dart';

class AddBaseStationsScreen extends StatefulWidget {
  const AddBaseStationsScreen(
      {super.key, this.numberOfStationsToAdd, this.station});

  final int? numberOfStationsToAdd;
  final BaseStationModel? station;

  @override
  State<AddBaseStationsScreen> createState() => _AddBaseStationsScreenState();
}

class _AddBaseStationsScreenState extends State<AddBaseStationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BaseStationVM>(
      onModelReady: (model) async {
        //set number of stations user wants to add for the counter to work
        if (widget.numberOfStationsToAdd != null) {
          model.baseStationsToAdd = widget.numberOfStationsToAdd!;
        }

        //when updating a station
        if (widget.station != null) {
          model.baseStationNameController.text = widget.station!.name;
          model.baseStationAddressController.text =
              widget.station!.address.address ?? '';
          model.pickedAddress = widget.station?.address;
        }

        //fetch user location/last location
        await model.getUserLocation();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor:
                  widget.numberOfStationsToAdd == null ? AppColors.green : null,
              foregroundColor:
                  widget.numberOfStationsToAdd == null ? AppColors.white : null,
              title: widget.numberOfStationsToAdd == null
                  ? const Text('Add Base Station')
                  : null,
              centerTitle: true,
              actions: widget.numberOfStationsToAdd == null
                  ? null
                  : [
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.numberOfStationsToAdd != null)
                      Text(
                        widget.numberOfStationsToAdd == 1
                            ? 'Add Base Station'
                            : 'Add Base Station (${model.baseStationsLeft} of ${model.baseStationsToAdd})',
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
                      key: model.key,
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
                            controller: model.baseStationNameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autocorrect: false,
                                  textCapitalization:
                                      TextCapitalization.sentences,
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
                                      model.baseStationAddressController,
                                  validator: (value) {
                                    if (model.pickedAddress == null) {
                                      return 'Search address or pick on map';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    model.searchPlaces(value);
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final PlaceModel? place = await context.push(
                                    AppRoutes.pickMapLocation,
                                    extra: model.pickedAddress,
                                  ) as PlaceModel?;
                                  if (place != null) {
                                    model.setPickedAddress(place);
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.map_pin_ellipse,
                                  color: AppColors.green,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: model.searchedAdresses.isNotEmpty,
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: model.searchedAdresses.length,
                          itemBuilder: (context, index) {
                            return LocationWidget(
                              onTap: (place) async {
                                FocusScope.of(context).unfocus();
                                model.addAddress([]);
                                model.setPickedAddress(place);
                              },
                              place: model.searchedAdresses[index],
                            );
                          },
                        ),
                      ),
                    ),
                    // const Spacer(),
                    sizexBoxH(50),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!model.key.currentState!.validate()) {
                            return;
                          }

                          widget.station == null
                              ? model.addBaseStation(
                                  context: context,
                                  name: model.baseStationNameController.text,
                                )
                              : model.updateBaseStation(
                                  context: context,
                                  name: model.baseStationNameController.text,
                                  station: widget.station!,
                                );
                          model.baseStationAddressController.clear();
                          model.baseStationNameController.clear();
                        },
                        child: Text(widget.station == null
                            ? 'Add Base Station'
                            : 'Update Base Station'),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
