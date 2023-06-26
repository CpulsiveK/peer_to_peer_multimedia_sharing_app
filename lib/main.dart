import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/screens/dashboard/dashboard.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/screens/onboarding/onboarding.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/screens/onboarding/login.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/screens/onboarding/splash_screen.ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MediaShareX());
}

class MediaShareX extends StatelessWidget {
  const MediaShareX({super.key});

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
