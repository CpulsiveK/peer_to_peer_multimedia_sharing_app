import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard.dart';
import 'ui/login.dart';
import 'ui/splash.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'splash',
    routes: {
      'splash': (context) => const Splash(),
      'login': (context) => const Login(),
      'dashboard': (context) => const Dashboard(),
    },
  ));
}
