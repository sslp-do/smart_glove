import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildFilterDropdown(String hint, Color bgColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(hint, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        const Icon(Icons.keyboard_arrow_down, size: 20),
      ],
    ),
  );
}