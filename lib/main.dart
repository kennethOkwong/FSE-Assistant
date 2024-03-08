import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fse_assistant/firebase_options.dart';
import 'package:oktoast/oktoast.dart';

import 'core/app theme/theme.dart';
import 'core/navigation/go_routes.dart';
import 'core/network/network_config.dart';
import 'core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //set app to run on portrait
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //initialise firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //set App Run mode
  Config.appFlavour = Flavour.development;

//dependency injection flutter
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        //setup to fit into bigger screens
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            title: 'FSE Assistant',
            routerConfig: goRouter,
          );
        },
      ),
    );
  }
}
