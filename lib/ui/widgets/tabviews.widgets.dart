import 'package:flutter/material.dart';

class TabViews extends StatelessWidget {
  const TabViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        const SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  DescriptonTexts('Ms Docs'),
                  DescriptonTexts('Excel'),
                  DescriptonTexts('Pdf'),
                ],
              ),
              SharedContent(30, Icon(size: 60, Icons.file_present_rounded)),
              Row(
                children: [
                  DescriptonTexts('Pictures'),
                  DescriptonTexts('Gifs'),
                ],
              ),
              SharedContent(30, Icon(size: 60, Icons.gif_box_outlined)),
              Row(
                children: [
                  DescriptonTexts('Video'),
                ],
              ),
              SharedContent(
                  30,
                  Icon(
                    size: 60,
                    Icons.video_file_rounded,
                  )),
              Row(
                children: [
                  DescriptonTexts('Audio'),
                ],
              ),
              SharedContent(
                  30,
                  Icon(
                    size: 60,
                    Icons.audiotrack_rounded,
                  )),
            ],
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
    );
  }
}

class SharedContent extends StatelessWidget {
  final int itemCount;
  final Icon icon;

  const SharedContent(
    this.itemCount,
    this.icon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: icon,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
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

class DescriptonTexts extends StatelessWidget {
  final String text;
  const DescriptonTexts(this.text, {super.key});

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
