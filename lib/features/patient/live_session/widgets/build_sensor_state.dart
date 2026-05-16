
import 'package:flutter/material.dart';

Widget buildSensorState(bool active){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: active?Colors.green:Colors.red),
    ),
    child: Row(
      children: [
        Icon(Icons.link, color:active?Colors.green:Colors.red, size: 16),
        const SizedBox(width: 8),
        Text(
          "Glove ${active ? "Active" : "Not Connected"}",
          style: TextStyle(
            color: active?Colors.green:Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

