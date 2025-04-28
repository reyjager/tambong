import 'package:firebase_core/firebase_core.dart';
import 'package:tambong/authentication/sign_in/signin_view.dart';
import 'package:tambong/firebase_options.dart';
// import 'package:tambong/splash/splash_view.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tambong',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: ThemeService.currentColorScheme.primaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: SplashView(),
      home: SignInView(),
    );
  }
}
