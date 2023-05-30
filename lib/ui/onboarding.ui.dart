import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/onboarding/onboarding-widgets.onboarding.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/onboarding/onboarding_utils.onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  TutorialPageState createState() => TutorialPageState();
}

class TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<TutorialData> tutorialData = [
    TutorialData(
      title: 'Get Started with our app',
      description: 'A peer-to-peer platform for sharing media between friends and family from anywhere without the use of Internet!',
      icon: null,
    ),
    TutorialData(
      title: 'Share your files with Everyone!',
      description: 'by using the share icon button at the bottom left corner of your dashboard\n\n',
      icon: const Icon(
        weight: 50,
        Icons.share,
        color: kBaseColour,
        size: 150.0,
      ),
    ),
    TutorialData(
      title: 'Search for any file!',
      description: 'using the search bar at the top of your dashboard\n\n',
      icon: const Icon(
        weight: 50,
        Icons.manage_search_rounded,
        color: kBaseColour,
        size: 200.0,
      ),
    ),
  ];

  int _currentPageIndex = 0;

  void _goToNextPage() {
    if (_currentPageIndex < tutorialData.length - 1) {
      _currentPageIndex++;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex--;
    }
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('screenShown', true);
    });

    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: tutorialData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return TutorialScreen(
                  tutorialData: tutorialData[index],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: _currentPageIndex > 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (_currentPageIndex > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextButton(
                    onPressed: _goToPreviousPage,
                    child: const Text(
                      'Prev',
                      style: kNavigatorText,
                    ),
                  ),
                ),
              if (_currentPageIndex < tutorialData.length - 1)
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextButton(
                      onPressed: _goToNextPage,
                      child: const Text(
                        'Next',
                        style: kNavigatorText,
                      ),
                    )),
              if (_currentPageIndex == tutorialData.length - 1)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: const Text(
                      'Done!',
                      style: kNavigatorText,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
