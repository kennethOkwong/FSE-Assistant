import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/features/base%20station/domain/models/place_model.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/survey/presentation/widgets/stations_found_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/widget_helpers.dart';
import '../view models/survey_vm.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/no_stations_widget.dart';

class BaseStationsScanScreen extends StatefulWidget {
  const BaseStationsScanScreen({super.key, required this.surveyLocation});

  final PlaceModel surveyLocation;

  @override
  State<BaseStationsScanScreen> createState() => _BaseStationsScanScreenState();
}

class _BaseStationsScanScreenState extends State<BaseStationsScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<SurveyViewModel>(
        onModelReady: (model) {
          model.surveyLocation(widget.surveyLocation);
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
                          target: LatLng(
                            widget.surveyLocation.lat ?? 0.00,
                            widget.surveyLocation.lng ?? 0.00,
                          )),
                      markers: model.mapMarkers,
                      polylines: model.polylines,
                      onMapCreated: (controller) async {
                        model.mapController.complete(controller);
                        // await model.loadMapIcon();
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
                        Icons.arrow_back,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ),
              ),
              if (!model.loading)
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
                      child: model.surveyData.isEmpty
                          ? const NoBaseStationsWidget()
                          : BaseStationsFoundWidget(
                              onTap: () {},
                              numberOfStations: model.surveyData.length,
                            ),
                    ),
                  ),
                ),
              if (model.loading) const CustomLoadingOverlay()
            ],
          );
        },
      ),
    );
  }
}
