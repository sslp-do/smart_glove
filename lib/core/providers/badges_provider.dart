import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_glove/core/models/badge_item.dart';
import 'package:smart_glove/features/patient/models/patient.dart';

class BadgesProvider extends ChangeNotifier{
  List<BadgeItem> _badges = [
    BadgeItem("First Step", "Complete your first session", Icons.flag, false, Colors.blue),
    BadgeItem("On Fire!", "7-day streak achieved", Icons.local_fire_department, false, Colors.orange),
    BadgeItem("Grip Master", "Reach 90% grip strength", Icons.handshake, false, Colors.purple),
    BadgeItem("Early Bird", "Complete a session before 8 AM", Icons.wb_sunny, false, Colors.amber),
    BadgeItem("Marathon", "Total 10 hours of training", Icons.timer, false, Colors.teal),
  ];
  List<BadgeItem> get all_Badges => _badges;

 void updateBadgeStatus(Patient patient){
    List<String> newList = List.from(patient.badges);

    if( patient.improvement > 10 && !newList.contains("Grip Master") )
    {
      newList.add("Grip Master");
    }
    if( patient.streak > 7 && !newList.contains("On Fire!") )
    {
      newList.add("On Fire!");
    }
    if( patient.totalSessions > 10 && !newList.contains("Marathon") )
    {
      newList.add("Marathon");
    }
    if (patient.weeklyProgress["Mon"] == 100 && !newList.contains("Early Bird"))
    {
      newList.add("Early Bird");
    }
    if (patient.totalSessions == 1 && !newList.contains("First Step"))
    {
      newList.add("First Step");
    }

    for (BadgeItem badge in _badges) {
      if (newList.contains(badge.title)) {
        badge.isUnlocked = true;
      } else {
        badge.isUnlocked = false;
      }
    }
    notifyListeners();
    }

  List<BadgeItem> updateAndGetBadges(Patient patient){
    List<String> newList = List.from(patient.badges);

    if( patient.improvement > 10 && !newList.contains("Grip Master") )
    {
      newList.add("Grip Master");
    }
    if( patient.streak > 7 && !newList.contains("On Fire!") )
    {
      newList.add("On Fire!");
    }
    if( patient.totalSessions > 10 && !newList.contains("Marathon") )
    {
      newList.add("Marathon");
    }
    if (patient.weeklyProgress["Mon"] == 100 && !newList.contains("Early Bird"))
    {
      newList.add("Early Bird");
    }
    if (patient.totalSessions == 1 && !newList.contains("First Step"))
    {
      newList.add("First Step");
    }

    for (BadgeItem badge in _badges) {
      if (newList.contains(badge.title)) {
        badge.isUnlocked = true;
      } else {
        badge.isUnlocked = false;
      }
    }
    return all_Badges;
    notifyListeners();
  }
  }
