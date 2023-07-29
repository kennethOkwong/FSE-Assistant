import 'package:flutter/material.dart';

import '../../../auth/presentation/screens/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const AuthScreen();
                },
              ));
              // await FirebaseAuthProvider.logOut();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
