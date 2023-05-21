import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextfieldEmpty = true;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_checkTextfieldEmpty);
  }

  void _checkTextfieldEmpty() {
    setState(() {
      _isTextfieldEmpty = _controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 150),
                const Text(
                  'MediaShareX',
                  style: TextStyle(
                      color: Color(0xFF1B0D6F),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 130,
                ),
                const Text(
                  'Enter a username which will be used to uniquely identify you on the network',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF1B0D6F),
                      fontSize: 24,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 170),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'username',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.indigo.shade900),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(150, 50)),
                          ),
                          onPressed: _isTextfieldEmpty
                              ? () => _showSnackBar(context)
                              : _onButtonPressed,
                          child: const Text(
                            "Let's go!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: const Text('username field cannot be left empty'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _onButtonPressed() async {
    final String id = _controller.text;
    id;

    Navigator.pushReplacementNamed(context, 'dashboard');
  }
}
