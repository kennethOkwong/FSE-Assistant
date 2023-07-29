import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fse_assistant/screens/home_screen.dart';
// import 'package:fse_assistant/screens/loading_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme_data.dart';
import 'config/routes.dart';

// import 'package:fse_assistant/screens/auth_screen.dart';
// import 'package:fse_assistant/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FSE Assistant',
      theme: themeData,
      routerConfig: goRouter,
      // showSemanticsDebugger: true,
    );
  }
}
