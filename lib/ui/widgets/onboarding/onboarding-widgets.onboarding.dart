import 'package:flutter/material.dart';

const kLogoText = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  color: kBaseColour,
);
const kTitleText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: kBaseColour,
);
const kNavigatorText = TextStyle(
  color: kBaseColour,
  fontSize: 20.0,
);
const kDescriptionText = TextStyle(
  fontSize: 24,
  color: kBaseColour,
);
const kTextFieldStyle = InputDecoration(
  // labelText: '',
  hintText: 'Enter username',
  // prefixIcon: Icon(Icons.person),
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: kBaseColour)),
);

const kBaseColour = Color(0xFF1B0D6F);

Icon kArrowStyles({IconData icon = Icons.arrow_forward_ios_rounded}) {
  return Icon(
    icon,
    size: 45,
    color: Colors.black,
  );
}
