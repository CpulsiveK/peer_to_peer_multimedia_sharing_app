import 'dart:io';
import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String indexerAddr = '';

  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    _getIndexerAddr();
    final flags = await _getFlags();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
          context,
          flags[1] != null
              ? 'dashboard'
              : flags[0] == true
                  ? 'login'
                  : 'onboarding',
          arguments: flags[1] != null
              ? {'id': flags[1], 'indexerAddr': indexerAddr}
              : {'indexerAddr': indexerAddr});
    });
  }

  void _getIndexerAddr() async {
    String message = "indexer ip?";

    try {
      await (RawDatagramSocket.bind(peerAddr, peerPort))
          .then((RawDatagramSocket socket) async {
        socket.broadcastEnabled = true; // Enable broadcasting

        // Convert the message to bytes
        List<int> messageBytes = message.codeUnits;

        while (indexerAddr.isEmpty) {
          // Broadcast the message to all devices on the LAN
          socket.send(messageBytes, InternetAddress(defaultIndexerAddr), 50000);
          print("Message broadcasted on the LAN");

          // Receive response
          await socket.forEach((event) {
            if (event == RawSocketEvent.read) {
              final datagram = socket.receive();
              String result = String.fromCharCodes(datagram!.data);

              setState(() {
                indexerAddr = result;
              });
            }
          });
        }
      }).catchError((e) {
        print("Error: $e");
      });
    } catch (e) {
      rethrow;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('indexerAddr', indexerAddr);
  }

  Future<List> _getFlags() async {
    final prefs = await SharedPreferences.getInstance();
    return [
      prefs.getBool('screenShown'),
      prefs.getString('username'),
      prefs.getString('indexerAddr')
    ];
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
