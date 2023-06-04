import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String searchText;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {
      searchText = _controller.text;
    });
  }

  void _selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      files;

      // Navigator.pushNamed(context, 'routeName', arguments: {'files': files});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;

    Peers peers = Peers(
        id: args['id'], indexerAddr: args['indexerAddr'], port: indexerPort);
    peers;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                    color: Colors.indigo.shade900, fontFamily: 'sans-serif'),
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    color: Colors.indigo.shade900),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.indigo.shade900),
                  onPressed: () {
                    _controller.clear();
                    _onSearchTextChanged();
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 50,
                itemBuilder: ((context, index) {
                  return null;
                }),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade900,
        onPressed: () async {
          final PermissionStatus status = await Permission.storage.request();
          debugPrint("[PERMISSION]: $status");

          _selectFile();
          // Navigator.pushNamed(context, 'file_manager');
        },
        child: const Icon(color: Colors.white, Icons.share),
      ),
    );
  }
}
