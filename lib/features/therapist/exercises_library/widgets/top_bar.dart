import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget topBar(BuildContext context) {
  final theme = Theme.of(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Exercises Library", style: theme.textTheme.displayMedium),
      Container(
        width: MediaQuery.of(context).size.width * 0.2,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Create New Exercise"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ],
  );
}
