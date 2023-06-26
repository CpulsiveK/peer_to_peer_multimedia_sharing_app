import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  final List<String> sharedFiles;
  final int itemCount;
  final Widget icon;

  const SeeAll(
      {Key? key,
      required this.sharedFiles,
      required this.itemCount,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Colors.teal,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            'Shared',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return ListTile(
              leading: icon,
              title: Text(
                sharedFiles[index].trim(),
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
