import 'package:flutter/material.dart';

class TherapistFeedbackScreen extends StatefulWidget {
  const TherapistFeedbackScreen({super.key});

  @override
  State<TherapistFeedbackScreen> createState() =>
      _TherapistFeedbackScreenState();
}

class _TherapistFeedbackScreenState extends State<TherapistFeedbackScreen> {
 /* final List<Map<String, dynamic>> _feedbacks = [
    {
      "id": 1,
      "patientName": "Sarah Connor",
      "date": "Today, 10:30 AM",
      "painLevel": 7,
      "message":
          "The wrist rotation exercise was very painful today. I couldn't complete the last 5 reps.",
      "exercise": "Wrist Rotation",
      "isReplied": false,
    },
    {
      "id": 2,
      "patientName": "Ahmad Ali",
      "date": "Yesterday, 04:15 PM",
      "painLevel": 2,
      "message":
          "Felt great! The glove tracking seems to be working perfectly. I feel my grip is stronger.",
      "exercise": "Full Fist Grip",
      "isReplied": true,
    },
    {
      "id": 3,
      "patientName": "Layla Omar",
      "date": "Yesterday, 09:00 AM",
      "painLevel": 5,
      "message":
          "Moderate pain in my thumb during the pinch exercise. Should I lower the target angle?",
      "exercise": "Pinch Grip",
      "isReplied": false,
    },
  ];*/

 // int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Patient Name
          header(),

          const SizedBox(height: 30),

          // Patient Message
          messageBox(),


          const SizedBox(height: 100),

          // Therapist Reply Box
          textBox(),

          const SizedBox(height: 30),

          // Buttons
          buttons(),
        ],
      ),
    );
  }
}

class header extends StatefulWidget {
  const header({super.key});

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  final List<Map<String, dynamic>> _feedbacks = [
    {
      "id": 1,
      "patientName": "Sarah Connor",
      "date": "Today, 10:30 AM",
      "painLevel": 7,
      "message":
      "The wrist rotation exercise was very painful today. I couldn't complete the last 5 reps.",
      "exercise": "Wrist Rotation",
      "isReplied": false,
    },
    {
      "id": 2,
      "patientName": "Ahmad Ali",
      "date": "Yesterday, 04:15 PM",
      "painLevel": 2,
      "message":
      "Felt great! The glove tracking seems to be working perfectly. I feel my grip is stronger.",
      "exercise": "Full Fist Grip",
      "isReplied": true,
    },
    {
      "id": 3,
      "patientName": "Layla Omar",
      "date": "Yesterday, 09:00 AM",
      "painLevel": 5,
      "message":
      "Moderate pain in my thumb during the pinch exercise. Should I lower the target angle?",
      "exercise": "Pinch Grip",
      "isReplied": false,
    },
  ];

  final cardColor = Colors.white;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Feedback from:",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              _feedbacks[_selectedIndex]['patientName'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        // Pain Degree
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              const Text(
                "Reported Pain",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                "${_feedbacks[_selectedIndex]['painLevel']}/10",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _feedbacks[_selectedIndex]['painLevel'] >= 6
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class messageBox extends StatefulWidget {
  const messageBox({super.key});

  @override
  State<messageBox> createState() => _messageBoxState();
}

class _messageBoxState extends State<messageBox> {
  final bgColor = Colors.grey[50];
  final cardColor = Colors.white;

  final List<Map<String, dynamic>> _feedbacks = [
    {
      "id": 1,
      "patientName": "Sarah Connor",
      "date": "Today, 10:30 AM",
      "painLevel": 7,
      "message":
          "The wrist rotation exercise was very painful today. I couldn't complete the last 5 reps.",
      "exercise": "Wrist Rotation",
      "isReplied": false,
    },
    {
      "id": 2,
      "patientName": "Ahmad Ali",
      "date": "Yesterday, 04:15 PM",
      "painLevel": 2,
      "message":
          "Felt great! The glove tracking seems to be working perfectly. I feel my grip is stronger.",
      "exercise": "Full Fist Grip",
      "isReplied": true,
    },
    {
      "id": 3,
      "patientName": "Layla Omar",
      "date": "Yesterday, 09:00 AM",
      "painLevel": 5,
      "message":
          "Moderate pain in my thumb during the pinch exercise. Should I lower the target angle?",
      "exercise": "Pinch Grip",
      "isReplied": false,
    },
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fitness_center, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Session: ${_feedbacks[_selectedIndex]['exercise']}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Text(
                _feedbacks[_selectedIndex]['date'],
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Text(
            "\"${_feedbacks[_selectedIndex]['message']}\"",
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class textBox extends StatefulWidget {
  const textBox({super.key});

  @override
  State<textBox> createState() => _textBoxState();
}

class _textBoxState extends State<textBox> {
  final bgColor = Colors.grey[50];
  final cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Doctor's Instructions (Reply)",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Type your clinical instructions here...",
            filled: true,
            fillColor: cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }
}

class buttons extends StatefulWidget {
  const buttons({super.key});

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Edit Exercise Plan",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 150,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send, color: Colors.white),
            label: const Text(
              "Send Reply",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
