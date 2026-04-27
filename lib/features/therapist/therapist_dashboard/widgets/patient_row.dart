import 'package:flutter/material.dart';

Widget buildPatientRow(Map<String, dynamic> patient, ThemeData theme) {
  final bool isOnline = patient['gloveStatus'] == 'Online';
  final bool isLowBattery = patient['battery'] <= 20;

  return InkWell(
    onTap: () {

    },
    hoverColor: theme.primaryColor.withOpacity(0.05),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // 1. المريض (الاسم والمعرف)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  child: Text(
                    patient['name'][0],
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient['id'],
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. الحالة الطبية
          Expanded(
            flex: 2,
            child: Text(
              patient['condition'],
              style: TextStyle(color: theme.textTheme.bodyMedium?.color),
            ),
          ),

          // 4. شريط التقدم
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(patient['progress'] * 100).toInt()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        patient['status'],
                        style: TextStyle(
                          fontSize: 11,
                          color: patient['status'] == 'Needs Review'
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: patient['progress'],
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    color: patient['progress'] > 0.8
                        ? Colors.green
                        : theme.primaryColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
          ),

          // 5. الإجراءات (زر عرض الملف)
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                color: Colors.blue,
                onPressed: () {
                  // فتح ملف المريض
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
