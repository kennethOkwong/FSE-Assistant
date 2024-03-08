import 'package:flutter/material.dart';
import 'package:fse_assistant/features/base/base_ui.dart';

import '../view models/auth_view_model.dart';
import '../widgets/authproviders_section.dart';
import '../widgets/email_auth_section.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraint.maxHeight,
                    minWidth: constraint.maxWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthProvidersSection(
                          isLogin: model.isLogin,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        EmailAuthSection(
                          model: model,
                          onAuthTap: (authDetails) async {
                            FocusScope.of(context).unfocus();
                            if (model.isLogin) {
                              model.login(
                                context: context,
                                details: authDetails,
                              );
                            } else {
                              model.register(
                                context: context,
                                details: authDetails,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ));
              },
            ),
          ),
        );
      },
    );
  }
}
