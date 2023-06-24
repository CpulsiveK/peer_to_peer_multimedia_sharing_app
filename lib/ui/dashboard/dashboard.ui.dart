import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard/selected-files-display.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/container.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/loading-animations.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/search.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/snackbar.ui.dart';
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
  List<PlatformFile> sharedFiles = [];

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
        builder: ((context) => SelectedFilesDisplay(
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
    setState(() {
      sharedFiles.addAll(receivedSharedFiles);
    });

    for (PlatformFile file in receivedSharedFiles) {
      if (file.extension == 'pdf' ||
          file.extension == 'docx' ||
          file.extension == 'xlsx' ||
          file.extension == 'pptx') {
        sharedFileDocuments.add(file.name);
      } else if (file.extension == 'jpg' ||
          file.extension == 'gif' ||
          file.extension == 'png') {
        sharedPictures.add(file.name);
      } else if (file.extension == 'mp4' || file.extension == 'mkv') {
        sharedVideos.add(file.name);
      } else if (file.extension == 'mp3') {
        sharedAudio.add(file.name);
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
      sharedFileDocuments = prefs.getStringList('sharedFIleDocuments')!;
      sharedPictures = prefs.getStringList('sharedPictures')!;
      sharedVideos = prefs.getStringList('sharedVideos')!;
      sharedAudio = prefs.getStringList('sharedAudio')!;
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
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            labelColor: Colors.teal,
            labelPadding: EdgeInsets.all(8.0),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.teal,
            tabs: [
              Tab(
                child: Text(
                  'Shared',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
              Tab(
                child: Text(
                  'Online',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Downloads',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              Column(key: const PageStorageKey('shared'), children: [
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ContainerViews(
                        sharedFiles: sharedFileDocuments,
                        icon: const Icon(Icons.file_present_rounded,
                            size: 40, color: Colors.teal),
                        sharedIcon: const Icon(
                          Icons.file_copy_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                        fileType: 'Shared files',
                        fileCount: sharedFileDocuments.length.toString(),
                      ),
                      ContainerViews(
                        sharedFiles: sharedPictures,
                        icon: const Icon(Icons.photo_outlined,
                            size: 40, color: Colors.teal),
                        sharedIcon: const Icon(Icons.photo_library_rounded,
                            size: 32, color: Colors.white),
                        fileType: 'Shared images',
                        fileCount: sharedPictures.length.toString(),
                      ),
                      ContainerViews(
                        sharedFiles: sharedVideos,
                        icon: const Icon(Icons.video_file_outlined,
                            size: 40, color: Colors.teal),
                        sharedIcon: const Icon(Icons.video_collection_rounded,
                            size: 32, color: Colors.white),
                        fileType: 'Shared videos',
                        fileCount: sharedVideos.length.toString(),
                      ),
                      ContainerViews(
                        sharedFiles: sharedAudio,
                        icon: const Icon(Icons.audiotrack_rounded,
                            size: 40, color: Colors.teal),
                        sharedIcon: const Icon(Icons.audiotrack_rounded,
                            size: 32, color: Colors.white),
                        fileType: 'Shared audio',
                        fileCount: sharedAudio.length.toString(),
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 12.0, 0.0, 10.0),
                      child: Text(
                        'Recently shared',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: sharedFiles.length,
                    itemBuilder: (context, index) {
                      final files = sharedFiles.reversed.toList();
                      Icon? icon;

                      switch (files[index].extension) {
                        case 'jpg':
                          icon = const Icon(
                            Icons.photo_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'png':
                          icon = const Icon(
                            Icons.photo_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'mp4':
                          icon = const Icon(
                            Icons.video_file_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'mkv':
                          icon = const Icon(
                            Icons.video_file_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'webm':
                          icon = const Icon(
                            Icons.video_file_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'mp3':
                          icon = const Icon(
                            Icons.audiotrack_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'opus':
                          icon = const Icon(
                            Icons.audiotrack_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'pdf':
                          icon = const Icon(
                            Icons.file_present_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'PDF':
                          icon = const Icon(
                            Icons.file_present_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'docx':
                          icon = const Icon(
                            Icons.file_present_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'xlsx':
                          icon = const Icon(
                            Icons.file_present_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'pptx':
                          icon = const Icon(
                            Icons.file_present_rounded,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        case 'gif':
                          icon = const Icon(
                            Icons.gif_box_outlined,
                            color: Colors.teal,
                            size: 40,
                          );
                          break;
                        default:
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.1),
                        child: ListTile(
                          leading: icon,
                          title: Text(
                            files[index].name,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
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
                backgroundColor: Colors.tealAccent,
                onPressed: () {
                  showSearch(
                      context: context, delegate: FileSearch(id: args['id']));
                },
                child: const Icon(Icons.search, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 28.0,
              right: 1.0,
              child: FloatingActionButton(
                backgroundColor: Colors.tealAccent,
                onPressed: selectFile,
                child: const Icon(Icons.share, color: Colors.black),
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
