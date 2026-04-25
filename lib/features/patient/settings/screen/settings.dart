import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/theme_provider.dart';

class PatientSettings extends StatefulWidget {
  const PatientSettings({super.key});

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.grey[50];
    final cardColor = Colors.white;
    final primaryColor = Colors.teal;

    return SingleChildScrollView(
      child: Column(
        children: [
          title(),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Smart Glove Integration",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsCard(cardColor, [
                  _buildSettingTile(
                    icon: Icons.bluetooth_connected,
                    iconColor: Colors.blue,
                    title: "Connection Status",
                    subtitle:
                        "Glove is currently connected via Bluetooth (COM3)",
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Disconnect",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    icon: Icons.tune,
                    iconColor: primaryColor,
                    title: "Calibrate Sensors",
                    subtitle:
                        "Run this tool if hand tracking feels inaccurate or drifting",
                    trailing: Container(
                      height: 100,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Run Calibration",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 40),

                const Text(
                  "App Preferences",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsCard(cardColor, [
                  SwitchListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Push Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: const Text(
                      "Receive doctor's notes and session reminders",
                    ),
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: const Text(
                      "Easier on the eyes in low light conditions",
                    ),
                    value: context.watch<ThemeProvider>().isDarkMode,
                    onChanged: context
                        .watch<ThemeProvider>()
                        .toggleTheme /*(val) => setState(() => _darkMode = val*/,
                  ),
                ]),
                const SizedBox(height: 40),

                const Text(
                  "Account & Support",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsCard(cardColor, [
                  _buildSettingTile(
                    icon: Icons.lock_outline,
                    iconColor: Colors.grey[700]!,
                    title: "Change Password",
                    subtitle: "Last changed 3 months ago",
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    icon: Icons.support_agent,
                    iconColor: Colors.grey[700]!,
                    title: "Contact Clinic",
                    subtitle:
                        "Get help with your treatment plan or report an issue",
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ]),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
      /*   ),
          ],
        )*/
    );
  }

  Widget title() {
    return Container(
      padding: const EdgeInsets.symmetric(
        // horizontal: 20,//32,
        vertical: 24,
      ),
      //  color: cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Settings & Device Management",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Icon(Icons.battery_charging_full, color: Colors.green[700]),
              const SizedBox(width: 8),
              const Text(
                "Glove Battery: 82%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    bool isActive,
    Color primaryColor,
  ) {
    final textColor = isActive ? primaryColor : Colors.grey[700];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildSettingsCard(Color cardColor, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 13),
      ),
      trailing: trailing,
      onTap: () {},
    );
  }
}
