import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/dashbaord/presentation/view%20models/dashboard_vm.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../../../base station/presentation/widgets/location_widget.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashBoardVM>(
      onModelReady: (model) async {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            title: const Text('Search Location'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                sizexBoxH(15),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.lightGreen,
                    ),
                    hintText: 'Type to search',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.lightGrey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onChanged: (value) {
                    model.searchPlaces(value);
                  },
                ),
                Visibility(
                  visible: model.searchedAdresses.isNotEmpty,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: model.searchedAdresses.length,
                      itemBuilder: (context, index) {
                        return LocationWidget(
                          onTap: (place) async {
                            FocusScope.of(context).unfocus();
                            context.pop(place);
                          },
                          place: model.searchedAdresses[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
