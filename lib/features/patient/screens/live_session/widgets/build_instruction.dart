import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';

Widget buildInstructions(BuildContext context) {
  final theme = Theme.of(context);
  final primaryColor = theme.primaryColor;
String hint = context.watch<SessionProvider>().currentHint;
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: primaryColor.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline, color: primaryColor),
        const SizedBox(width: 10),
        Text(
          hint,
          style: theme.textTheme.displayMedium!.copyWith(
            color: theme.primaryColor,
            fontSize: 22,
          ),
        ),
      ],
    ),
  );
}