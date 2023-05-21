import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    final isScreenShown = await getFlag();

    Future.delayed(const Duration(seconds: 5), () {
      if (isScreenShown == true) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'onboarding');
      }
    });
  }

  Future<bool?> getFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('screenShown');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF1B0D6F),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MediaShareX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ));
  }
}
