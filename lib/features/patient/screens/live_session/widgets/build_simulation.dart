import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_metric_card.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';
import 'package:smart_glove/features/patient/screens/live_session/widgets/hand_visual.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Widget buildSimulation(BuildContext context) {
  Theme.of(context);
  final cardColor = Colors.transparent;


  return Container(
    height: 400,
    width: double.infinity,
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cardColor, Theme.of(context).primaryColor.withOpacity(0.05)],
      ),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child:
      /*HandVisualizer(
        sensorValue: 0.9,
        isTargetFist: true,
      ),*/
      /*    HandVisual(
              snapshot: FingerSnapshot(thumb: 23,
                  index: 23,
                  middle: 23,
                  ring: 23,
                  pinky: 23),
              weakFingerIndex: 0,
            ),*/
      /*   StreamBuilder(
              // الاتصال المباشر بالمسار الفعلي المطابق تماماً لملف الـ JSON
              stream: FirebaseDatabase.instance
                  .ref("sessions/session_20260601_172034/readings")
                  .limitToLast(1)
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                // قيم الأمان الافتراضية لليد (مفتوحة بالكامل 0°) لمنع أي توقف
                double thumb = 0.0;
                double index = 0.0;
                double middle = 0.0;
                double ring = 0.0;
                double little = 0.0;

                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  try {
                    Map<dynamic, dynamic> readingsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                    if (readingsMap.isNotEmpty) {
                      var lastPushKey = readingsMap.keys.first;
                      var fingers = readingsMap[lastPushKey]['fingers'];

                      if (fingers != null) {
                        // 🎯 تم تعديل الحقل لـ 'degree' ليطابق هيكلية الهاردوير الحقيقية 100%
                        thumb  = (fingers['Thumb']?['degree'] ?? 0.0).toDouble();
                        index  = (fingers['Index']?['degree'] ?? 0.0).toDouble();
                        middle = (fingers['Middle']?['degree'] ?? 0.0).toDouble();
                        ring   = (fingers['Ring']?['degree'] ?? 0.0).toDouble();
                        little = (fingers['Pinky']?['degree'] ?? 0.0).toDouble(); // يقرأ من عقدة Pinky الحقيقية للهاردوير
                      }
                    }
                  } catch (e) {
                    print("Error parsing live visualization data: $e");
                  }
                }

                // بناء لقطة الأصابع الحية بالقيم الصحيحة المكتشفة
                final liveSnapshot = FingerSnapshot(
                  thumb: thumb,
                  index: index,
                  middle: middle,
                  ring: ring,
                  pinky: little,
                );

                // تمرير الـ Snapshot للوجت الخاصة بكِ لتتحرك فوراً أمام المشرفين!
                return HandVisual(
                  snapshot: liveSnapshot,
                  weakFingerIndex: 1, // الإصبع المستهدف بالتمرين (السبابة مثلاً)
                );
              },
            )*/
      /*StreamBuilder(
            // 🎯 سنصنع بثاً محلياً يرسل أرقاماً متحركة كل ثانية بدون الحاجة للإنترنت أو الفايربيز حالياً
            stream: Stream.periodic(
              const Duration(seconds: 1),
              (count) => count,
            ),
            builder: (context, snapshot) {
              // حساب زوايا متحركة ديناميكياً لتري مجسم اليد وهو يفتح ويغلق تماماً أمامكِ
              double waveAngle = (snapshot.data ?? 0) % 2 == 0 ? 80.0 : 10.0;

              final testSnapshot = FingerSnapshot(
                thumb: waveAngle,
                // Thumb
                index: waveAngle * 1.1,
                // Index
                middle: waveAngle * 1.05,
                // Middle
                ring: waveAngle * 0.95,
                // Ring
                pinky: waveAngle * 0.85, // Pinky
              );

              // عرض اليد الحية؛ ستفتح الشاشة فوراً وتتحرك الأصابع مية بالمية!
              return HandVisual(snapshot: testSnapshot, weakFingerIndex: 1);
            },
          ),*/
      /*StreamBuilder(
        // 🎯 الاتصال المباشر بالمسار الفعلي لملف الـ JSON الموجود بقاعدتكِ حالياً
        stream: FirebaseDatabase.instance
            .ref("sessions/session_20260601_172034/readings")
            .limitToLast(1)
            .onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          // قيم افتراضية آمنة (اليد مفتوحة بنسبة بسيطة) حتى لا تقف الشاشة أبدًا
          double thumb = 15.0;
          double index = 20.0;
          double middle = 20.0;
          double ring = 15.0;
          double little = 10.0;

          // طمأنينة في الـ Console: فحص حالة البث الحركي
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("⏳ فلاتر يحاول الاتصال بالفايربيز والاستماع للقفاز...");
          }

          if (snapshot.hasError) {
            print("❌ خطأ اتصال خارجي بالفايربيز: ${snapshot.error}");
          }

          // إذا وصلت الداتا الحقيقية من الفايربيز بنجاح
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            try {
              Map<dynamic, dynamic> readingsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              if (readingsMap.isNotEmpty) {
                var lastPushKey = readingsMap.keys.first;
                var fingers = readingsMap[lastPushKey]['fingers'];

                if (fingers != null) {
                  // 🎯 القراءة بالحقول الحقيقية المكتشفة 'degree' و 'Pinky'
                  thumb  = (fingers['Thumb']?['degree'] ?? thumb).toDouble();
                  index  = (fingers['Index']?['degree'] ?? index).toDouble();
                  middle = (fingers['Middle']?['degree'] ?? middle).toDouble();
                  ring   = (fingers['Ring']?['degree'] ?? ring).toDouble();
                  little = (fingers['Pinky']?['degree'] ?? little).toDouble();

                  print("🟢 ممتاز! لقطنا داتا حقيقية لايف من الفايربيز: السبابة = $index");
                }
              }
            } catch (e) {
              print("❌ حدث مشكلة أثناء تفكيك داتا الفايربيز: $e");
            }
          }

          // بناء لقطة الأصابع وضخها في مجسم اليد
          final liveSnapshot = FingerSnapshot(
            thumb: thumb,
            index: index,
            middle: middle,
            ring: ring,
            pinky: little,
          );

          return HandVisual(
            snapshot: liveSnapshot,
            weakFingerIndex: 1,
          );
        },
      )*/
     /* StreamBuilder(
        // 🎯 أنبوب محلي يقوم بإرسال طلب للفايربيز عبر الـ REST API كل ثانية واحدة بدون الحزمة الرسمية
        stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
          try {
            // الرابط الحقيقي الفعلي لقاعدة بياناتكِ متبوعاً بـ .json في الآخر للقراءة الأمنية
            final url = Uri.parse("https://ai-glove-default-rtdb.firebaseio.com/sessions.json");//?print=pretty&limitToLast=1
            final response = await http.get(url);

            if (response.statusCode == 200 && response.body != 'null') {
              return json.decode(response.body) as Map<String, dynamic>;
            }
          } catch (e) {
            print("❌ خطأ شبكة خارجي: $e");
          }
          return null;
        }),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          // قيم الأمان الافتراضية لليد (مفتوحة بالكامل 0°) لمنع أي توقف للواجهة
          double thumb = 0.0;
          double index = 0.0;
          double middle = 0.0;
          double ring = 0.0;
          double little = 0.0;

          if (snapshot.hasData && snapshot.data != null) {
            try {Map<String, dynamic> allSessionsMap = snapshot.data!;

            if (allSessionsMap.isNotEmpty) {
              // 1. ترتيب مجلدات الجلسات تلقائياً وجلب اسم أحدث جلسة فتحها القفاز للتو (مثل session_20260602_...)
              var sortedSessionKeys = allSessionsMap.keys.toList()..sort();
              var latestSessionKey = sortedSessionKeys.last;

              // حفظ المفتاح تلقائياً في الـ SessionProvider عشان نستخدمه بكرا في زر الإنهاء والـ AI
              context.read<SessionProvider>().currentFirebaseSessionKey = latestSessionKey;

              // 2. الدخول لبيانات الحركة (readings) داخل هذه الجلسة الأحدث
              var readingsMap = allSessionsMap[latestSessionKey]['readings'];

              if (readingsMap != null && readingsMap is Map) {
                // 3. جلب أحدث لقطة قراءة في قاع الـ readings
                var sortedReadingKeys = readingsMap.keys.toList()..sort();
                var lastPushKey = sortedReadingKeys.last;
                var fingers = readingsMap[lastPushKey]['fingers'];

                if (fingers != null) {
                  thumb  = (fingers['Thumb']?['degree'] ?? 0.0).toDouble();
                  index  = (fingers['Index']?['degree'] ?? 0.0).toDouble();
                  middle = (fingers['Middle']?['degree'] ?? 0.0).toDouble();
                  ring   = (fingers['Ring']?['degree'] ?? 0.0).toDouble();
                  little = (fingers['Pinky']?['degree'] ?? 0.0).toDouble();
                }
              }}
            } catch (e) {
              print("Error parsing http firebase data: $e");
            }
          }

          // بناء لقطة الأصابع وضخها في مجسم اليد
          final liveSnapshot = FingerSnapshot(
            thumb: thumb,
            index: index,
            middle: middle,
            ring: ring,
            pinky: little,
          );
*/
           HandVisual(
            snapshot: context.watch<SessionProvider>().currentGloveData,
            weakFingerIndex: 1,
          )
/*return   Wrap(
  spacing: 10,
  runSpacing: 8,
  alignment: WrapAlignment.center,
  children: List.generate(5, (i) => SizedBox(
    width: 200,
    child: FingerMetricCard(
      name: FingerSnapshot.fingerNames[i],
      romPercent: liveSnapshot.values[i],
      band: bandForValue(liveSnapshot.values[i]),
   //   isWeakest: i == weakIndex,
    ),
  )),
);*/


      )

  );
}
