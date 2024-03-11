import 'package:flutter/material.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/dashboard_vm.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<DashBoardVM>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Drawer(
          width: 270,
          backgroundColor: AppColors.white,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                ),
                child: ListTile(
                  title: const Text(
                    'Menu',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close, color: AppColors.white),
                    iconSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: const ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text('Home'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_rounded),
                title: const Text('Survey History'),
                onTap: () {
                  context.pop();
                  context.push(AppRoutes.surveyHistory);
                },
              ),
              ListTile(
                leading: const Icon(Icons.online_prediction_sharp),
                title: const Text('Base Stations'),
                onTap: () {
                  context.pop();
                  context.push(AppRoutes.baseStations);
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_mark_rounded),
                title: const Text('FAQs'),
                onTap: () {
                  context.pop();
                  context.push(AppRoutes.faq);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: const Text('Terms & Condition'),
                onTap: () {
                  context.pop();
                  context.push(AppRoutes.terms);
                },
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: AppColors.red),
                ),
                onTap: () {
                  model.logout(context);
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
