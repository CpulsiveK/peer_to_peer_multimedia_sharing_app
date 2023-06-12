import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/loading-animations.ui.dart';

class ContentDisplay extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  final String id;

  const ContentDisplay(
      {Key? key,
      required this.files,
      required this.onOpenedFile,
      required this.id})
      : super(key: key);

  @override
  State<ContentDisplay> createState() => _ContentDisplayState();
}

class _ContentDisplayState extends State<ContentDisplay>
    with AutomaticKeepAliveClientMixin {
  FilePickerResult? result;

  void selectFile() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingAnimation());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    Navigator.of(context).pop();

    if (result == null) return;

    loadSelectedFiles(result!.files);
  }

  void loadSelectedFiles(List<PlatformFile> newFiles) {
    setState(() {
      widget.files.addAll(newFiles);
    });
  }

  void navigateToDashboard() {
    final Map indexerFiles = {};

    for (PlatformFile file in widget.files) {
      indexerFiles[file.name] = file.path;
    }

    Peers.makeFilesPublic(fileInfo: indexerFiles, id: widget.id);

    Navigator.pop(context, widget.files);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Colors.deepPurple,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            'Selected',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: selectFile,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          IconButton(
              onPressed: navigateToDashboard,
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.builder(
            key: const PageStorageKey('contentDisplay'),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.files.length,
            itemBuilder: (context, int index) {
              final files = widget.files[index];
              Icon? icon;

              switch (files.extension) {
                case 'jpg':
                  icon = const Icon(Icons.photo_outlined, size: 50);
                  break;
                case 'png':
                  icon = const Icon(Icons.photo_outlined, size: 50);
                  break;
                case 'mp4':
                  icon = const Icon(Icons.video_file_outlined, size: 50);
                  break;
                case 'mkv':
                  icon = const Icon(
                    Icons.video_file_outlined,
                    size: 50,
                  );
                  break;
                case 'mp3':
                  icon = const Icon(Icons.audiotrack_rounded, size: 50);
                  break;
                case 'pdf':
                  icon = const Icon(Icons.file_present_rounded, size: 50);
                  break;
                case 'docx':
                  icon = const Icon(Icons.file_present_rounded, size: 50);
                  break;
                case 'xlsx':
                  icon = const Icon(Icons.file_present_rounded, size: 50);
                  break;
                case 'pptx':
                  icon = const Icon(Icons.file_present_rounded, size: 50);
                  break;
                case 'gif':
                  icon = const Icon(Icons.gif_box_outlined, size: 50);
                  break;
                default:
              }

              final kb = files.size / 1024;
              final mb = kb / 1024;
              final fileSize = (mb >= 1)
                  ? '${mb.toStringAsFixed(2)} MB'
                  : '${kb.toStringAsFixed(2)} KB';

              return Card(
                elevation: 0,
                child: ListTile(
                  leading: icon,
                  title: Text(
                    files.name.trim(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    fileSize,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () {
                      setState(() {
                        widget.files.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
