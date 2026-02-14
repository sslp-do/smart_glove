import 'package:flutter/material.dart';
import 'package:smart_glove/core/theme/app_colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // App Logo area
          Icon(Icons.health_and_safety, size: 60, color: theme.primaryColor),
          const SizedBox(height: 10),
          Text("GloveRehab", style: theme.textTheme.titleLarge),
          const SizedBox(height: 50),

          // Menu Items
          _buildMenuItem(Icons.dashboard, "Dashboard", true, context),
          _buildMenuItem(Icons.analytics, "My Reports", false, context),
          _buildMenuItem(Icons.chat, "Chat with Therapist", false, context),
          _buildMenuItem(Icons.settings, "Settings", false, context),

          const Spacer(),
          _buildMenuItem(Icons.logout, "Logout", false, context, isRed: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  Widget _buildMenuItem(
      IconData icon,
      String title,
      bool isActive,
      BuildContext context, {
        bool isRed = false,
      }) {
    final theme = Theme.of(context);
    final color = isRed
        ? theme.colorScheme.error
        : (isActive ? theme.primaryColor : Colors.grey);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isRed
              ? theme.colorScheme.error
              : (isActive ? AppColors.success : theme.colorScheme.secondary),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isRed
                ? theme.colorScheme.error
                : (isActive ? AppColors.success : theme.colorScheme.secondary),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {}, // Add navigation logic here
      ),
    );
  }
}