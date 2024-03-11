import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view models/base_station_vm.dart';

class PickMapLocationScreen extends StatelessWidget {
  const PickMapLocationScreen({super.key, this.location});

  final PlaceModel? location;

  @override
  Widget build(BuildContext context) {
    return BaseView<BaseStationVM>(
      onModelReady: (model) {
        log(model.pickedAddress?.address ?? 'Adderess is nul');
      },
      builder: (context, model, child) {
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            context.pop(model.pickedAddress);
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GoogleMap(
                          buildingsEnabled: false,
                          mapType: MapType.terrain,
                          compassEnabled: false,
                          mapToolbarEnabled: false,
                          initialCameraPosition: CameraPosition(
                            tilt: 50,
                            zoom: 15,
                            target: location != null
                                ? LatLng(
                                    location?.lat ?? 0.00,
                                    location?.lng ?? 0.00,
                                  )
                                : const LatLng(
                                    5.019563584179674,
                                    7.888179508520339,
                                  ),
                          ),
                          markers: {
                            if (model.locationMaker != null)
                              model.locationMaker!
                          },
                          onMapCreated: (controller) async {
                            model.mapController.complete(controller);
                            await model.loadMapIcon();
                          },
                          onTap: (argument) {
                            model.getMapAddress(argument);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.lightGreen),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.green,
                          ),
                          onPressed: () {
                            context.pop(model.pickedAddress);
                          },
                        ),
                      ),
                    ),
                  ),
                  if (model.locationMaker != null)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        // height: 200,
                        width: deviceWidth(context),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5,
                              offset: const Offset(5, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: paddingA(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Base Station Location',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              sizexBoxH(10),
                              Text(
                                'Drag and tab on the map to pick your base station location',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              sizexBoxH(20),
                              Text(
                                model.pickedAddress?.address ??
                                    location?.address ??
                                    'No address picked',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.green),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
