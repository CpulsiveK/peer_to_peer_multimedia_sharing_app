import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/screens/shared/see-all.ui.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/colors.ui.dart';

class ContainerViews extends StatelessWidget {
  final List<String> sharedFiles;
  final Widget icon;
  final Widget sharedIcon;
  final String fileType;
  final String fileCount;

  const ContainerViews(
      {super.key,
      required this.sharedFiles,
      required this.icon,
      required this.sharedIcon,
      required this.fileType,
      required this.fileCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 8.0),
        child: Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
                      child: sharedIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        fileType,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      fileCount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
                  ],
                )
              ],
            )),
      ),
      onTap: () {
        if (sharedFiles.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SeeAll(
                  sharedFiles: sharedFiles,
                  itemCount: sharedFiles.length,
                  icon: icon)));
        }
      },
    );
  }
}
