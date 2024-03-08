import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/app_images.dart';

import '../../../../core/app theme/app_colors.dart';

class AuthProvidersSection extends StatelessWidget {
  const AuthProvidersSection({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Welcome back!' : 'Create an Account',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.facebook,
              size: 40,
              color: Color.fromARGB(255, 31, 138, 225),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                AppImages.googleLogo,
                scale: 0.7,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              const Divider(),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.white,
                  child: Text(
                    isLogin ? 'OR SIGN IN WITH' : 'OR SIGN UP WITH',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
