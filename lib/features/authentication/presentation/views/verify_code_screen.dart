import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/app_images.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base/base_ui.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/auth_view_model.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key, required this.email});

  final String email;

  final _formKey = GlobalKey<FormState>();
  final _resetLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    // final height = deviceHeight(context);

    return BaseView<AuthViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20
                  // bottom: 30,
                  ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.resetPassword2,
                    width: width * 0.6,
                    height: width * 0.6,
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Text(
                    'Code Verification',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: width * 0.045,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Copy the link sent to $email and paste below to verify. \n Alternatively, follow the link from your email to complete password reset',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontSize: width * 0.040,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text('Password reset link'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      controller: _resetLinkController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Invalid link';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                model.verifyResetCode(
                                    context: context,
                                    email: email,
                                    resetPasswordLink:
                                        _resetLinkController.text.trim());
                              }
                            },
                            child: const Text(
                              'Verify Code',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
