import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/ui/login/screen/login.dart';

import '../../../../core/providers/navigation_provider.dart';

class PatientSideMenu extends StatelessWidget {
  final bool isCollapsed;

  const PatientSideMenu({super.key, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
  String   routName = context.watch<NavigationProvider>().currentRoute;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 80 : 250,
      color: theme.cardTheme.color,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // App Logo area
          Icon(
            Icons.health_and_safety,
            size: isCollapsed ? 30 : 60,
            color: theme.primaryColor,
          ),

          if (!isCollapsed) ...[
            const SizedBox(height: 10),
            Text("GloveRehab", style: theme.textTheme.titleLarge),
          ],

          const SizedBox(height: 50),
          // Menu Items
          _buildMenuItem(Icons.dashboard, "Dashboard", context, routeName: "overview"),
          _buildMenuItem(Icons.analytics, "My Reports",  context , routeName: "my_reports"),
          _buildMenuItem(Icons.settings, "Settings", context , routeName: "settings"),
          const Spacer(),
          _buildMenuItem(
            Icons.logout,
            "Logout",
            context,
            isLogout: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    BuildContext context, {
    bool isLogout = false,
        String routeName = "",
  }) {
    bool isActive = context.watch<NavigationProvider>().currentRoute == routeName;
    final theme = Theme.of(context);
    final color = isLogout
        ? theme.colorScheme.error
        : (isActive ? theme.primaryColor : theme.textTheme.bodyMedium!.color);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: isCollapsed
            ? null
            : Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
        onTap: () {
          if (isLogout) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
          context.read<NavigationProvider>().changeRoute(routeName);
        },
      ),
    );
  }
}
