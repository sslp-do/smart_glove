import 'package:flutter/cupertino.dart';
import 'package:smart_glove/features/patient/models/glove_status.dart';

class GloveProvider with ChangeNotifier {
  GloveStatus _status = GloveStatus(battery: 40, isConnected: false);

  GloveStatus get status => _status;

  // الاستماع لحالة القفاز من الـ Stream (Firebase Realtime Database)
  void monitorGloveStatus(Stream<GloveStatus> statusStream) {
    statusStream.listen((newStatus) {
      _status = newStatus;
      notifyListeners(); // هذا سيحدث الـ Top Bar فقط إذا استخدمنا الـ Consumer صح
    });
  }
}