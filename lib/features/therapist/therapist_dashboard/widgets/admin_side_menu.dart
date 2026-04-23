// =========================================================
// 1. (Admin Side Menu)
// =========================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/ui/login/screen/login.dart';

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
            "Dr. Ahmad",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),

          _buildMenuItem(context, Icons.grid_view, "Overview", "overview"),
          _buildMenuItem(context, Icons.people_outline, "All Patients", "all_patients"),
          _buildMenuItem(
            context,
            Icons.fitness_center,
            "Exercises Library",
           "exercises"
          ), _buildMenuItem(
            context,
            Icons.feedback_outlined,
            "Feedbacks",
           "feedback"
          ),
          _buildMenuItem(
            context,
            Icons.analytics_outlined,
            "AI Analytics",
            "ai_reports"
          ),

          const Spacer(),
          _buildMenuItem(
            context,
            Icons.logout,
            "Logout",
         "logout",
            isLogout: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
      String routeName,
  {
    bool isLogout = false,
  }) {
    bool isActive = context.watch<NavigationProvider>().currentRoute == routeName;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = isLogout
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
        onTap:() {
          if (isLogout) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
          context.read<NavigationProvider>().changeRoute(routeName);
        } ,
      ),
    );
  }
}
