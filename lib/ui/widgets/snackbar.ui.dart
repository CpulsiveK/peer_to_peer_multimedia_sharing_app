import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }