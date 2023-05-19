import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard.dart';
import 'ui/file_manager/homepage.file_manager.dart';
import 'ui/login.dart';
import 'ui/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'dashboard',
    routes: {
      'splash': (context) => const Splash(),
      'login': (context) => const Login(),
      'dashboard': (context) => const Dashboard(),
      'file_manager': (context) => const HomePage()
    },
  ));
}
