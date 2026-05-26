
import 'package:flutter/material.dart';

Widget buildSettingsCard(Color cardColor, List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey[200]!),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10),
      ],
    ),
    child: Column(children: children),
  );
}