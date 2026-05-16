import 'package:flutter/material.dart';

Widget buildSettingTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required Widget trailing,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    leading: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(color: Colors.grey[600], fontSize: 13),
    ),
    trailing: trailing,
    onTap: () {},
  );
}