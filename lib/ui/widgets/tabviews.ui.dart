import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/dashboard/see-all.ui.dart';

class SharedContent extends StatelessWidget {
  final List<String> sharedFiles;
  final int itemCount;
  final Widget icon;

  const SharedContent(
      {Key? key,
      required this.sharedFiles,
      required this.itemCount,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                  child: SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            icon,
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            sharedFiles[index],
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    if (itemCount > 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SeeAll(sharedFiles: sharedFiles, itemCount: itemCount, icon: icon,),
                      ));
                    }
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class DescriptionTexts extends StatelessWidget {
  final String text;
  const DescriptionTexts(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 4.0, 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  final String text;
  const Tabs(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
