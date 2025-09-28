import 'package:flutter/material.dart';

class SettingsLanguageSelector extends StatelessWidget {
  const SettingsLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.language, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Language',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            'English',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
