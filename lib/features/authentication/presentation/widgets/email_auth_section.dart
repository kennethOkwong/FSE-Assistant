import 'package:flutter/material.dart';
import 'package:fse_assistant/core/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/auth_view_model.dart';

class EmailAuthSection extends StatefulWidget {
  const EmailAuthSection({
    super.key,
    required this.onAuthTap,
    required this.model,
  });

  final AuthViewModel model;
  final Function(AuthDetails authDetails) onAuthTap;

  @override
  State<EmailAuthSection> createState() => _EmailAuthSectionState();
}

class _EmailAuthSectionState extends State<EmailAuthSection> {
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;
  bool _privacyStatus = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Form Fields
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: _emailController,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'Invalid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Password'),
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
                    borderRadius: BorderRadius.all(Radius.circular(15)),
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
                  if (!widget.model.isLogin &&
                      value != _confirmPasswordController.text) {
                    return 'Password missmatch';
                  }
                  return null;
                },
              ),
              if (widget.model.isLogin)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push(AppRoutes.resetPasswordEmail);
                      },
                      child: const Text('Forgot Password?'),
                    )
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              if (!widget.model.isLogin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Confirm Password'),
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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

                        if (!widget.model.isLogin &&
                            value != _passwordController.text) {
                          return 'Password missmatch';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _privacyStatus,
                          onChanged: (value) {
                            setState(() {
                              _privacyStatus = value!;
                            });
                          },
                        ),
                        Text(
                          'I agree to the Privacy Policy',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),

        //Submit form/toggle login&register screens button
        Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAuthTap(AuthDetails(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  }
                },
                child: Text(
                  widget.model.isLogin ? 'Login' : 'Register',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.model.isLogin
                    ? 'Don\'t have an account?'
                    : 'Already have an account?'),
                TextButton(
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                    widget.model.toggleAuthScreen();
                  },
                  child: Text(widget.model.isLogin ? 'Register' : 'Login'),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class AuthDetails {
  final String email;
  final String password;

  AuthDetails({
    required this.email,
    required this.password,
  });
}
