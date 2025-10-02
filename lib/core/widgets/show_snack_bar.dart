import 'package:flutter/material.dart';

void showSnackBar({
  required String message,
  required LinearGradient color,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
      content: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(message, style: const TextStyle(color: Colors.black)),
      ),
      behavior: SnackBarBehavior.floating,
      closeIconColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
