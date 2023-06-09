import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers_utils.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/content-display.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/loading-animations.widgets.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/snackbar.widgets.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/tabviews.widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FilePickerResult? result;

  void selectFile() async {
    if (await Permission.storage.request().isGranted) {

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LoadingAnimation());

      result = await FilePicker.platform.pickFiles(allowMultiple: true);
      Navigator.of(context).pop();

      if (result == null) return;

      loadSelectedFiles(result!.files);

      
    } else {
      showSnackBar(context, 'Cannot access device storage without permission');
    }
  }

  void loadSelectedFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) =>
            ContentDisplay(files: files, onOpenedFile: viewFiles))));
  }

  void viewFiles(PlatformFile file) {
    OpenFile.open(file.path!);
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
          title: const Text(
            'Dashboard',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.deepPurple,
            labelPadding: EdgeInsets.all(8.0),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepPurple,
            tabs: [Tabs('Shared'), Tabs('Online'), Tabs('Downloads')],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TabViews(),
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
                onPressed: selectFile,
                child: const Icon(Icons.share, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// change size of icons on dashboard
