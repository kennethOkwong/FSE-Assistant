import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/custom_snackbar.dart';
import '../widgets/faq_tile.dart';

class FaqsScreen extends ConsumerWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FaqTile(
                title: 'What is FSE ASSISTANT used for?',
                content:
                    'Field Service Engineer (FSE) Assistant is an app that aids Network Engineers in carrying out a seamless wireless link feasibility survey.',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'Who is ‘FSE Assistant’ built for?',
                content:
                    'FSE Assistant is built for Network Engineers working with an Internet Service Provider (ISP).',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'Why is adding my base stations important?',
                content:
                    'Adding base stations helps us calculate and provide the distances between them and your customer location during link surveys.',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'Can I survey a customer location remotely?',
                content:
                    'Yes, by searching or picking customer’s location on map. However, being on site will aid you provide some details needed to produce a comprehensive report.',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'Can I keep history of my surveys?',
                content:
                    'Yes. All your surveys are saved under ‘Survey History’ menu and can be referenced or shared when needed.',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'How do I collaborate with my teammates?',
                content:
                    'We are working on allowing team leads add team mates to company accounts. However, a temporary solution might be creating a single account, adding base stations and then sharing the login details with teammates.',
              ),
              SizedBox(
                height: 10,
              ),
              FaqTile(
                title: 'What is the team behind the wheel?',
                content:
                    'FSE Assistant is built by Team Cadenny. The UI/UX design is done by Judith Emenike, Mobile Development by Kenneth Okwong (Computer Engineering Graduates of UNIUYO). Firebase is used for Backend.',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final url = Uri.parse(
              'mailto:cadenny2021@gmail.com?subject=Feedback%20from%20FSE%20Assistant%20user&body=Hi%20Team,');

          if (!await launchUrl(url)) {
            customSnackbar(
              context: context,
              content: 'Unable to open email app',
              success: false,
            );
          }
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
