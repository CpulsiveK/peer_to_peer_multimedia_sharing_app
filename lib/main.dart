import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard/dashboard.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/onboarding/onboarding.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/onboarding/login.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/onboarding/splash_screen.ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'onboarding': (context) => const TutorialPage(),
        'login': (context) => const Login(),
        'dashboard': (context) => const Dashboard(),
      },
    );
  }
}
