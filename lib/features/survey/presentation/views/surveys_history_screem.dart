import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/survey/presentation/view%20models/survey_vm.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/empty_screen.dart';

class SurveyHistoryScreen extends StatefulWidget {
  const SurveyHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SurveyHistoryScreenState();
}

class _SurveyHistoryScreenState extends State<SurveyHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SurveyViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            centerTitle: true,
            title: const Text('Surveys'),
          ),
          body: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: EmptyScreen(
                title: 'No Survey History',
                description: 'Click + to begin a survey',
              )),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.go(AppRoutes.dashboard);
            },
          ),
        );
      },
    );
  }
}
