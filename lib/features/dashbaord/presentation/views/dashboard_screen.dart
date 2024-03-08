import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/dashbaord/presentation/view%20models/dashboard_vm.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/widget_helpers.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashBoardVM>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
          ),
          body: Stack(
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
                        target: model.userCurrentLocation != null
                            ? LatLng(
                                model.userCurrentLocation?.lat ?? 0.00,
                                model.userCurrentLocation?.lng ?? 0.00,
                              )
                            : model.userLastLocation != null
                                ? LatLng(
                                    model.userLastLocation?.lat ?? 0.00,
                                    model.userLastLocation?.lng ?? 0.00,
                                  )
                                : model.defaultLocation,
                      ),
                      markers: {
                        if (model.locationMaker != null) model.locationMaker!
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
              if (model.locationMaker != null)
                Positioned(
                  bottom: 0,
                  child: Container(
                    // height: 200,
                    width: deviceWidth(context),
                    color: AppColors.white,
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
                          // Text(
                          //   model.pickedAddress?.address ??
                          //       location?.address ??
                          //       'No address picked',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .titleMedium!
                          //       .copyWith(color: AppColors.green),
                          //   textAlign: TextAlign.center,
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
          drawer: CustomDrawer(model: model),
        );
      },
    );
  }
}
