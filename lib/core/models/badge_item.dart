import 'package:flutter/material.dart';

class BadgeItem {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final Color color;

  BadgeItem(this.title, this.description, this.icon, this.isUnlocked, this.color);
}

final List<BadgeItem> demoBadges = [
  BadgeItem("First Step", "Complete your first session", Icons.flag, true, Colors.blue),
  BadgeItem("On Fire!", "7-day streak achieved", Icons.local_fire_department, true, Colors.orange),
  BadgeItem("Grip Master", "Reach 90% grip strength", Icons.handshake, false, Colors.purple),
  BadgeItem("Early Bird", "Complete a session before 8 AM", Icons.wb_sunny, false, Colors.amber),
  BadgeItem("Marathon", "Total 10 hours of training", Icons.timer, false, Colors.teal),
];