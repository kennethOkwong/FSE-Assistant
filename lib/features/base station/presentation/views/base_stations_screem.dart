import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/core/utils/shimmer_loader.ui.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/empty_screen.dart';
import '../view models/base_station_vm.dart';
import '../widgets/base_station_list_item.dart';

class BaseStationsScreen extends StatefulWidget {
  const BaseStationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BaseStationsScreenState();
}

class _BaseStationsScreenState extends State<BaseStationsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    return BaseView<BaseStationVM>(
      onModelReady: (model) {
        model.getBaseStations();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            title: const Text('Base Stations'),
            centerTitle: true,
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 50),
            child: model.loadingStations
                ? ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const ShimmerCart(),
                          sizexBoxH(width * 0.05)
                        ],
                      );
                    },
                  )
                : model.baseStationList.isEmpty
                    ? const EmptyScreen(
                        title: 'No Base Station saved',
                        description: 'Click + to add a base station',
                      )
                    : ListView.builder(
                        itemCount: model.baseStationList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              BaseStationListItem(
                                title: model.baseStationList[index].name,
                                address: model.baseStationList[index].address
                                        .address ??
                                    '',
                                onSelected: (value) {
                                  if (value == MenuOptions.delete) {
                                    model.deleteBaseStation(
                                        context: context,
                                        stationId: model
                                            .baseStationList[index].stationId);
                                  } else {
                                    context.push(
                                      AppRoutes.editStation,
                                      extra: model.baseStationList[index],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        },
                      ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.push(
                AppRoutes.addBaseStation,
                extra: null,
              );
            },
          ),
        );
      },
    );
  }
}
