import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';

class AdminTopBar extends StatelessWidget {
  const AdminTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: theme.cardTheme.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /*SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search patient by name or ID...",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: theme.scaffoldBackgroundColor,
              ),
            ),
          ),*/
          Text(context.watch<NavigationProvider>().currentRoute, style: theme.textTheme.displayMedium),
          const CircleAvatar(
            backgroundColor: Colors.cyan,
            child: Text(
              "Dr",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
         /* Row(
            children: [
              IconButton(
                icon: const Badge(
                  label: Text("3"),
                  child: Icon(Icons.notifications_none),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 20),

            ],
          )*/
        ],
      ),
    );
  }
}