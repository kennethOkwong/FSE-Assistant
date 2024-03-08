import 'package:flutter/material.dart';
import 'package:fse_assistant/core/app%20theme/app_colors.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';

import '../widgets/terms_section.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
        title: const Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingH(width * 0.025),
          child: Column(
            children: [
              sizexBoxH(width * 0.02),
              const Text(
                'Welcome to our FSE app! We appreciate your interest in using our app to streamline your field service activities. Before you get started, please take a moment to carefully read these Terms and Conditions ("Terms"). By using our app, you agree to be bound by these Terms. If you have any questions or concerns, feel free to reach out to our team. ',
                textAlign: TextAlign.justify,
              ),
              TermsSectionWidget(
                width: width,
                header: '1. Account Registration',
                body:
                    'a. To access and use the app, you need to create an account. During registration, please provide accurate and up-to-date information. We want to ensure that your account is secure and personalized to your needs. \nb. You are responsible for keeping your account information confidential and for any activity that occurs under your account. \nc. We may suspend or terminate your account if you violate these Terms or engage in unauthorized or illegal activities.',
              ),
              TermsSectionWidget(
                  width: width,
                  header: '2. App Usage and Intellectual Property',
                  body:
                      'a. Our app and its content belong to us and are protected by intellectual property laws. We grant you a limited, non-transferable right to use the app for its intended purpose. \nb. Modifying, reproducing, distributing, or creating derivative works based on our app or its content without our prior written consent is prohibited.'),
              TermsSectionWidget(
                  width: width,
                  header: '3.Limitations of Liability',
                  body:
                      'a. We strive to provide accurate and reliable information through our app, but we cannot guarantee the completeness, accuracy, or reliability of the content. \nb. We are not liable for any direct, indirect, incidental, consequential, or punitive damages arising from the use of our app or its content.'),
              TermsSectionWidget(
                  width: width,
                  header: '4. Indemnification',
                  body:
                      'a. You agree to indemnify and hold us harmless from any claims, losses, damages, liabilities, and expenses arising from your use of the app, violation of these Terms, or infringement of any third-party rights.'),
              TermsSectionWidget(
                  width: width,
                  header: '5.Modifications to the App Terms',
                  body:
                      'a. We may modify, suspend, or discontinue the app or any part of its content without prior notice. \nb. From time to time, we may revise these Terms. By continuing to use the app after any modifications, you accept the revised Terms.'),
              TermsSectionWidget(
                  width: width,
                  header: '6. Governing Law and Jurisdiction',
                  body:
                      'a. These Terms are governed by and construed in accordance with the laws of Nigeria. \nb. Any disputes arising from these Terms are subject to the exclusive jurisdiction of the courts located in Nigeria.'),
              TermsSectionWidget(
                  width: width,
                  header: '7. Severability',
                  body:
                      'a. If any provision of these Terms is deemed invalid or unenforceable, the remaining provisions will remain in full force and effect.'),
            ],
          ),
        ),
      ),
    );
  }
}
