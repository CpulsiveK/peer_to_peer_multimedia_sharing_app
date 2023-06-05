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

  @override
  void initState() {
    super.initState();
  }

  void _selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (File file in files) {
        print('[FILE].......${file.path}');
      }

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
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            labelColor: Colors.white,
            labelPadding: EdgeInsets.all(8.0),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Shared',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Downloads',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // Expanded(
              //   child: ListView.builder(itemBuilder: (BuildContext context, int index) {},
              //     // ...
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 90.0,
              right: 1.0,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                onPressed: () async {},
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 28.0,
              right: 1.0,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                onPressed: () async {
                  final PermissionStatus status =
                      await Permission.storage.request();
                  debugPrint("[PERMISSION]: $status");
    
                  _selectFile();
                  // Navigator.pushNamed(context, 'file_manager');
                },
                child: const Icon(Icons.share, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
