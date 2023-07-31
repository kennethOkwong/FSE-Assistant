import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/core/screens/error_screen.dart';
import 'package:fse_assistant/core/screens/loading_screen.dart';
import 'package:fse_assistant/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_snackbar.dart';
import '../controllers/provider.dart';
import '../widgets/authproviders_section.dart';
import '../widgets/email_auth_section.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authproviderMethods = ref.read(authStateNotifierProvider.notifier);
    final authProviderState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: authProviderState.when(
        data: (data) {
          return data!.fold(
            (l) => authWidget(authproviderMethods),
            (r) => const HomeScreen(),
          );
        },
        error: (error, stackTrace) => const ErrorScreen(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget authWidget(AuthStateNotifier authproviderMethods) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                      isLogin: ref.watch(authProvider),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    EmailAuthSection(
                      onAuthTap: (authDetails) async {
                        final isLogin = ref.read(authProvider);
                        late final dynamic userOrFailureObject;

                        if (isLogin) {
                          userOrFailureObject = await authproviderMethods.login(
                            authDetails.email,
                            authDetails.password,
                          );
                        } else {
                          userOrFailureObject =
                              await authproviderMethods.signup(
                            authDetails.email,
                            authDetails.password,
                          );
                        }
                        userOrFailureObject!.fold(
                          (l) => customSnackbar(
                            context: context,
                            content: l.message,
                            success: false,
                          ),
                          (r) => context.go('/home'),
                        );
                      },
                      onScreenChanged: () async {
                        ref.read(authProvider.notifier).toggleAuthPage();
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
  }
}
