import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/widgets/onboarding/onboarding-widgets.onboarding.dart';

class TutorialData {
  final String title;
  final String description;
  final Icon? icon;

  TutorialData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class TutorialScreen extends StatelessWidget {
  final TutorialData tutorialData;

  const TutorialScreen({super.key, required this.tutorialData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tutorialData.title,
          style: kTitleText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            tutorialData.description,
            style: kDescriptionText,
            textAlign: TextAlign.center,
          ),
        ),
        if (tutorialData.icon != null) tutorialData.icon!,
      ],
    );
  }
}