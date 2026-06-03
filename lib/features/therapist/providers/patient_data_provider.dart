import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/models/patient.dart';

class PatientDataProvider extends ChangeNotifier {

  List<Patient> _allPatients = [];

  String searchQuery = "";

  String _selectedStatusFilter = 'All'; // الفلتر المختار حالياً (All, Critical...)

  List<Patient> get allPatients => _allPatients;

  String get selectedStatusFilter => _selectedStatusFilter;

  PatientDataProvider(){
    fetchPatients();
  }

  void updateSearchQuery(String query){
    searchQuery = query;
    notifyListeners();
  }

  // 1. دالة جلب البيانات الموحدة من الفايربيس للجدولين
  Future<void> fetchPatients() async {
    try {
      _allPatients = [
        Patient(
          id: "#PT-1042",
          name: "Sarah Connor",
          totalSessions: 23,
          streak: 2,
          recoveryProgress: 0.8,
          badges: [],
          weeklyProgress: {},
          affectedHand: "Left Hand",
          status: "Improving", // ممررة لجدول الـ Triage
          lastSessionTime: "2 hours ago",
          diagnosis: "Post-Stroke (Left Hand)", // ممررة لجدول All Patients
        ),
        Patient(
          id: "#PT-1043",
          name: "Ahmad Ali",
          totalSessions: 14,
          streak: 0,
          recoveryProgress: 0.4,
          badges: [],
          weeklyProgress: {},
          affectedHand: "Right Hand",
          status: "Critical",
          lastSessionTime: "3 days ago",
          diagnosis: "Carpal Tunnel Syndrome",
        ),
        Patient(
          id: "#PT-1044",
          name: "Layla Omar",
          totalSessions: 45,
          streak: 5,
          recoveryProgress: 0.95,
          badges: [],
          weeklyProgress: {},
          affectedHand: "Right Hand",
          status: "Improving", // أو Completed حسب رغبتكِ
          lastSessionTime: "Yesterday",
          diagnosis: "Fracture Recovery (Right)",
        ),
        Patient(
          id: "#PT-1045",
          name: "John Doe",
          totalSessions: 8,
          streak: 1,
          recoveryProgress: 0.2,
          badges: [],
          weeklyProgress: {},
          affectedHand: "Left Hand",
          status: "Plateau",
          lastSessionTime: "1 week ago",
          diagnosis: "Tendon Repair",
        ),
        Patient(
          id: "#PT-1046",
          name: "Mona Zaki",
          totalSessions: 19,
          streak: 3,
          recoveryProgress: 0.55,
          badges: [],
          weeklyProgress: {},
          affectedHand: "Right Hand",
          status: "Improving",
          lastSessionTime: "Just now",
          diagnosis: "Arthritis Management",
        ),
      ];
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching patients: $e");
    }
  }

  // 2. دالة الفلترة الذكية الخاصة بجدول الـ Patients Triage (الجدول الثاني)
  List<Patient> get filteredStatusPatients {
    if (_selectedStatusFilter == 'All') {
      return _allPatients;
    }
    return _allPatients
        .where((p) =>
    p.status.toLowerCase() == _selectedStatusFilter.toLowerCase())
        .toList();
  }

  // 3. تغيير الفلتر عند الضغط على الأزرار (All, Critical, Plateau, Improving)
  void changeStatusFilter(String newFilter) {
    _selectedStatusFilter = newFilter;
    notifyListeners();
  }

  // 4. دالة البحث بالاسم أو الـ ID الخاصة بالجدول الأول
  List<Patient> searchPatients(String query) {
    if (query.isEmpty) return _allPatients;
    return _allPatients.where((p) =>
    p.name.toLowerCase().contains(query.toLowerCase()) ||
        p.id.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}