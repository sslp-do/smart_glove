import 'package:flutter/material.dart';

class BadgeItem {
  final String title;
  final String description;
  final IconData icon;
   bool isUnlocked;
  final Color color;

  BadgeItem(this.title, this.description, this.icon, this.isUnlocked, this.color);
}


