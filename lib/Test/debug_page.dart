// lib/features/test/glove_monitor_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/Test/stream_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monitorProvider = context.read<TestMonitorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Glove Data Testing")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
         //   context.read<SessionProvider>().testAiPayloadUpload();
          },
          child: Text("data"),
        ),
      ),

      /*StreamBuilder<DocumentSnapshot>(
        stream: monitorProvider.gloveDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          final Map<String, dynamic>? rawJson =
              snapshot.data?.data() as Map<String, dynamic>?;

          if (rawJson == null)
            return const Center(
              child: Text("No data yet"),
            );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Last data received :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(),

              ...rawJson.entries.map((entry) {
                return ListTile(
                  leading: const Icon(
                    Icons.settings_input_component,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "${entry.key}:",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${entry.value}",
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                );
              }).toList(),
              const Divider(),
              Text(
                "Time: ${DateTime.now().toString().split('.')[0]}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          );
        },
      ),*/
    );
  }
}
