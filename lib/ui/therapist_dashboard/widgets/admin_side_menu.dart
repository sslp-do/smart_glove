// =========================================================
// 1. (Admin Side Menu)
// =========================================================
import 'package:flutter/material.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardTheme.color;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: 250,
      color: cardColor,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.admin_panel_settings, size: 60, color: primaryColor),
          const SizedBox(height: 10),
          const Text(
            "Dr. Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),

          _buildMenuItem(context, Icons.grid_view, "Overview", true),
          _buildMenuItem(context, Icons.people_outline, "All Patients", false),
          _buildMenuItem(
            context,
            Icons.fitness_center,
            "Exercises Library",
            false,
          ),
          _buildMenuItem(
            context,
            Icons.analytics_outlined,
            "AI Analytics",
            false,
          ),

          const Spacer(),
          _buildMenuItem(context, Icons.logout, "Logout", false, isRed: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      bool isActive, {
        bool isRed = false,
      }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = isRed
        ? Colors.redAccent
        : (isActive ? primaryColor : theme.textTheme.bodyMedium?.color);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      )
          : null,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}