import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final provider = ref.watch(authStateNotifierProvider.notifier);
    final response = ref.watch(authStateNotifierProvider);
    return Scaffold(
      body: SafeArea(
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
                          await provider.login(
                              authDetails.email, authDetails.password);
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
      ),
    );
  }
}
