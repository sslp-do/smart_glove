import 'package:flutter/material.dart';

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
          // شريط البحث
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search patient by name or ID...",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: theme.scaffoldBackgroundColor,
              ),
            ),
          ),
          // ملف الطبيب والإشعارات
          Row(
            children: [
              IconButton(
                icon: const Badge(
                  label: Text("3"),
                  child: Icon(Icons.notifications_none),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 20),
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
            ],
          ),
        ],
      ),
    );
  }
}