// lib/providers/test_monitor_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestMonitorProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> get gloveDataStream {
    return _firestore
        .collection('patients')
        .doc('test_patient_id')
        .collection('sessions')
        .doc('live_stream')
        .snapshots();
  }
}