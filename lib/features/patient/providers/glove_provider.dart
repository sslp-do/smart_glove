import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smart_glove/features/patient/models/glove_status.dart';

class GloveProvider with ChangeNotifier {
  GloveStatus _status = GloveStatus(battery: 40, isConnected: false);

  GloveStatus get status => _status;
  StreamSubscription? _subscription;

  // الاستماع لحالة القفاز من الـ Stream (Firebase Realtime Database)
  void monitorGloveStatus(Stream<GloveStatus> statusStream) {
    _subscription?.cancel();
    _subscription = statusStream.listen((newStatus) {
      _status = newStatus;
      notifyListeners(); // هذا سيحدث الـ Top Bar فقط إذا استخدمنا الـ Consumer صح
    });
  }
  @override
  void dispose() {
    _subscription?.cancel(); // ✅ نظف لما الـ Provider يتدمر
    super.dispose();
  }
}