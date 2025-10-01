import 'package:flutter/material.dart';

void showSnackBar(String message, Color color, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
