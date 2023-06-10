import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: const TextStyle(fontSize: 16,
          fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.deepPurple,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }