import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard/see-all.ui.dart';

class Cards extends StatelessWidget {
  final List<String> sharedFiles;
  final Widget icon;

  const Cards({super.key, required this.sharedFiles, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 12.0, 10.0, 8.0),
        child: Material(
          elevation: 1,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Container(
            height: 100,
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
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
