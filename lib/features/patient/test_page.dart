/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/models/session_model.dart';
import 'package:smart_glove/core/services/firestore_service.dart';

import '../../core/providers/session_provider.dart';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Test Page"),
            ElevatedButton(
              onPressed: () async {
                SessionModel testSession = SessionModel(
                  id: '',
                  date: DateTime.now(),
                  score: 85,
                  patientName: "Sara Ahmad",
                );


                await FirestoreService().addSession(testSession);


                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session Added Successfully'),
                  ),
                );
              },
              child: Text("Test Add Session"),
            ),
            ElevatedButton(
              onPressed: () async {
      try {
      print("نبدأ محاولة الجلب...");


      var snapshot = await FirebaseFirestore.instance.collection('sessions').get();

      print("تم جلب ${snapshot.docs.length} وثيقة بنجاح!");

      for (var doc in snapshot.docs) {
      print("بيانات الجلسة: ${doc.data()}");
      }
      } catch (e, stacktrace) {
      // هذا السطر سيطبع لكِ الخطأ الحقيقي مهما كان
      print("أمسكنا الخطأ!: $e");
      print("مكان الخطأ: $stacktrace");
      }
      },
              child: Text("Test Get All Sessions"),
            ),
           Container(
             width: MediaQuery.of(context).size.width,
             height: 300,
             child:
           Consumer<SessionProvider>(
             builder: (context, sessionProvider, child) {
               if (sessionProvider.isLoading) {
                 return const Center(child: CircularProgressIndicator());
               }

               if (sessionProvider.sessions.isEmpty) {
                 return const Center(child: Text("لا توجد جلسات مسجلة بعد"));
               }

               return ListView.builder(
                 itemCount: sessionProvider.sessions.length,
                 itemBuilder: (context, index) {
                   final session = sessionProvider.sessions[index];
                   return ListTile(
                     title: Text(session.patientName),
                     subtitle: Text(session.date.toString()),
                     trailing: Text("النتيجة: ${session.score}"),
                   );
                 },
               );
             },
           ),)
          ],
        ),
      ),
    );
  }
}
*/
