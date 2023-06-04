import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/onboarding.ui.dart';
import 'ui/login.ui.dart';
import 'ui/splash_screen.ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
    initialRoute: 'splash',
    routes: {
      'splash': (context) => const SplashScreen(),
      'onboarding': (context) => const TutorialPage(),
      'login': (context) => const Login(),
      'dashboard': (context) => const Dashboard(),
    },
  ));
}
