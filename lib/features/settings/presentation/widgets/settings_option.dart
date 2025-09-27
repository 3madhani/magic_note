import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final VoidCallback? onTap;

  const SettingsOption({
    super.key,
    required this.title,
    this.value,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          if (value != null)
            Text(value!, style: TextStyle(color: Colors.white, fontSize: 14)),
          if (icon != null)
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
