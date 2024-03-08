import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_routes.dart';

class Page404 extends StatelessWidget {
  const Page404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page Not Found'),
            OutlinedButton(
              onPressed: () {
                context.go(AppRoutes.splash);
              },
              child: const Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
