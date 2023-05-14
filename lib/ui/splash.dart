import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import '../network_logic/peers_utils.dart';
// import 'dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    instantiatePeer();
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B0D6F),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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
