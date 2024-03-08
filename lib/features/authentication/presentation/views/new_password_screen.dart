import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/app_images.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/authentication/presentation/view%20models/auth_view_model.dart';
import 'package:fse_assistant/features/base/base_ui.dart';

import '../../../../core/app theme/app_colors.dart';

class NewPasswordEmailScreen extends StatefulWidget {
  NewPasswordEmailScreen({super.key, required this.code});

  final String code;

  @override
  State<NewPasswordEmailScreen> createState() => _NewPasswordEmailScreenState();
}

class _NewPasswordEmailScreenState extends State<NewPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                children: [
                  Image.asset(
                    AppImages.resetPassword3,
                    width: width * 0.6,
                    height: width * 0.6,
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Text(
                    'New Password',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: width * 0.045,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter your new password. Password should be one not used before',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontSize: width * 0.040,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('New Password'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: _passwordVisibility,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordVisibility = !_passwordVisibility;
                                });
                              },
                              child: Icon(
                                _passwordVisibility
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            if (value != _confirmPasswordController.text) {
                              return 'Password missmatch';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text('Confirm New Password'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: _confirmPasswordVisibility,
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _confirmPasswordVisibility =
                                      !_confirmPasswordVisibility;
                                });
                              },
                              child: Icon(
                                _confirmPasswordVisibility
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            if (value != _passwordController.text) {
                              return 'Password missmatch';
                            }
                            return null;
                          },
                        ),
                      ],
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
                                model.resetPassword(
                                  context: context,
                                  code: widget.code,
                                  newPassword: _confirmPasswordController.text,
                                );
                              }
                            },
                            child: const Text(
                              'Next',
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
