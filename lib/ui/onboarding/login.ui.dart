import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/snackbar.ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    final Object? args = ModalRoute.of(context)!.settings.arguments;
    data = args as Map;
    indexerAddr = args['indexerAddr'];
    print(args);

    return GestureDetector(
      onTap: () {
        // Hide the keyboard when the user taps outside of the input fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height) * (68 / 100),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(120)),
                    color: Colors.deepPurple),
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
                      key: const PageStorageKey('usernameField'),
                      controller: _controller,
                      onTapOutside: (event) {},
                      decoration: const InputDecoration(
                        hintText: 'username',
                      ),
                      style: const TextStyle(fontSize: 16),
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
                                        Colors.deepPurple),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(80, 50)),
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
                                    fontSize: 16,
                                    color: Colors.white),
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

  @override
  bool get wantKeepAlive => true;
}
