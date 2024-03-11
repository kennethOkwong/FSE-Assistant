import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/core/utils/snack_message.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/dashbaord/presentation/view%20models/dashboard_vm.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      body: BaseView<DashBoardVM>(
        onModelReady: (model) {
          model.getUserLocation();
        },
        builder: (context, model, child) {
          return Stack(
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
              Padding(
                padding: const EdgeInsets.only(top: 45),
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
                        Icons.menu_sharp,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
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
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(30),
                        topStart: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            offset: const Offset(5, 0)),
                      ],
                    ),

                    child: Padding(
                      padding: paddingA(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 35,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                          sizexBoxH(20),
                          Text(
                            'Survey Location',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Drag and tap on map to change survey location.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          sizexBoxH(10),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                color: AppColors.green,
                              ),
                              sizexBoxW(5),
                              Expanded(
                                child: Text(
                                  model.surveyAddress?.address ??
                                      'No survey location picked',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.green,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          sizexBoxH(20),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    model.goToSearchAddress(context);
                                  },
                                  child: Text(
                                    'Search Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColors.green),
                                  ),
                                ),
                              ),
                              sizexBoxW(15),
                              Expanded(
                                child: FilledButton(
                                  onPressed: () {
                                    if (model.surveyAddress == null) {
                                      showCustomToast(
                                          'Please pick a survey location',
                                          success: false);
                                      return;
                                    }
                                    context.push(AppRoutes.scanStation,
                                        extra: model.surveyAddress);
                                  },
                                  child: Text(
                                    'Start Survey',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}
