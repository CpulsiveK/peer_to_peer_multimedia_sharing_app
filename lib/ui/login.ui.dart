import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/snackbar.widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextfieldEmpty = true;
  String indexerAddr = '';
  Map data = {};

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
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    data = args as Map;
    indexerAddr = args['indexerAddr'];
    print(args);

    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          // reverse: true,
          child: Column(
            children: <Widget>[
              Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: Color(0xFF1B0D6F)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MediaShareX',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Let's identify you on the network",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'username',
                      ),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(150, 50)),
                              ),
                              onPressed: _isTextfieldEmpty
                                  ? () => showSnackBar(context,
                                      'username field cannot be left empty')
                                  : _onButtonPressed,
                              child: const Text(
                                "Let's go!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF1B0D6F)),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() async {
    final String id = _controller.text.trim();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', id);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, 'dashboard',
        arguments: {'id': id, 'indexerAddr': indexerAddr});
  }
}
