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

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final flags = await _getFlags();

    Future.delayed(const Duration(seconds: 5), () {
      if (flags[1] != null) {
        Navigator.pushReplacementNamed(context, 'dashboard');
      } else if (flags[0] == true) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'onboarding');
      }
    });
  }

  Future<List> _getFlags() async {
    final prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('screenShown'), prefs.getString('username')];
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MediaShareX',
                style: TextStyle(
                    color: Color(0xFF1B0D6F),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ));
  }
}
