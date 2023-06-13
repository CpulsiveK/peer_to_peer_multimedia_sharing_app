import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard/content-display.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/loading-animations.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/search.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/snackbar.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/tabviews.ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  Map args = {};
  FilePickerResult? result;
  List<PlatformFile> receivedSharedFiles = [];

  List<String> sharedFileDocuments = [];
  List<String> sharedPictures = [];
  List<String> sharedVideos = [];
  List<String> sharedAudio = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCache();
    });
  }

  void selectFile() async {
    if (await Permission.storage.request().isGranted) {
      // ignore: use_build_context_synchronously
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

  void loadSelectedFiles(List<PlatformFile> files) async {
    receivedSharedFiles = await Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => ContentDisplay(
              files: files,
              onOpenedFile: viewFiles,
              id: args['id'],
            ))));

    categorizeFiles();
  }

  void viewFiles(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void categorizeFiles() {
    for (PlatformFile file in receivedSharedFiles) {
      if (file.extension == 'pdf' ||
          file.extension == 'docx' ||
          file.extension == 'xlsx' ||
          file.extension == 'pptx') {
        setState(() {
          sharedFileDocuments.add(file.name);
        });
      } else if (file.extension == 'jpg' ||
          file.extension == 'gif' ||
          file.extension == 'png') {
        setState(() {
          sharedPictures.add(file.name);
        });
      } else if (file.extension == 'mp4' || file.extension == 'mkv') {
        setState(() {
          sharedVideos.add(file.name);
        });
      } else if (file.extension == 'mp3') {
        setState(() {
          sharedAudio.add(file.name);
        });
      }
    }

    cacheSharedFiles();
  }

  void cacheSharedFiles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('sharedFIleDocuments', sharedFileDocuments);
    await prefs.setStringList('sharedPictures', sharedPictures);
    await prefs.setStringList('sharedVideos', sharedVideos);
    await prefs.setStringList('sharedAudio', sharedAudio);
  }

  void loadCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      sharedFileDocuments = prefs.getStringList('sharedFileDocuments') ?? [];
      sharedPictures = prefs.getStringList('sharedPictures') ?? [];
      sharedVideos = prefs.getStringList('SharedVideos') ?? [];
      sharedAudio = prefs.getStringList('sharedAudio') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    args = ModalRoute.of(context)!.settings.arguments as Map;

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
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            labelColor: Colors.deepPurple,
            labelPadding: EdgeInsets.all(8.0),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepPurple,
            tabs: [Tabs('Shared'), Tabs('Online'), Tabs('Downloads')],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              ListView(
                key: const PageStorageKey('shared'),
                children: [
                  const Row(
                    children: [
                      DescriptionTexts('Ms Docs'),
                      DescriptionTexts('Excel'),
                      DescriptionTexts('Pdf'),
                    ],
                  ),
                  SharedContent(
                      sharedFiles: sharedFileDocuments,
                      itemCount: sharedFileDocuments.length,
                      icon: const Icon(size: 60, Icons.file_open_outlined)),
                  const Row(
                    children: [
                      DescriptionTexts('Pictures'),
                      DescriptionTexts('Gifs'),
                    ],
                  ),
                  SharedContent(
                      sharedFiles: sharedPictures,
                      itemCount: sharedPictures.length,
                      icon: const Icon(size: 60, Icons.photo_library_rounded)),
                  const Row(
                    children: [
                      DescriptionTexts('Video'),
                    ],
                  ),
                  SharedContent(
                      sharedFiles: sharedVideos,
                      itemCount: sharedVideos.length,
                      icon: const Icon(
                        size: 60,
                        Icons.video_collection_outlined,
                      )),
                  const Row(
                    children: [
                      DescriptionTexts('Audio'),
                    ],
                  ),
                  SharedContent(
                      sharedFiles: sharedAudio,
                      itemCount: sharedAudio.length,
                      icon: const Icon(
                        size: 60,
                        Icons.audiotrack_rounded,
                      )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const Card();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const Card();
                  },
                ),
              )
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
                onPressed: () {
                  showSearch(context: context, delegate: FileSearch(id: args['id']));
                },
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

  @override
  bool get wantKeepAlive => true;
}
