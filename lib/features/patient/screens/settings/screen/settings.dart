import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/settings_providers.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/screens/settings/widgets/build_setting_card.dart';
import 'package:smart_glove/features/patient/screens/settings/widgets/build_setting_tile.dart';

class PatientSettings extends StatefulWidget {
  const PatientSettings({super.key});

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  /*bool _notificationsEnabled = true;
  bool _darkMode = false;*/

  @override
  Widget build(BuildContext context) {
    bool connected = context.watch<GloveProvider>().status.isConnected;
    final settings = context.watch<SettingsProvider>();
    final cardColor = Colors.white;
    final primaryColor = Colors.teal;

    return SingleChildScrollView(
      child: Column(
        children: [
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
                buildSettingsCard(cardColor, [
                  buildSettingTile(
                    icon: Icons.bluetooth_connected,
                    iconColor: Colors.blue,
                    title: "Connection Status",
                    subtitle:
                        "Glove is ${!settings.isGloveConnected} currently connected to your device",
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text(
                       !settings.isGloveConnected?"Connect": "Disconnect",
                        style: TextStyle(color:!connected? Colors.red: Colors.green),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  buildSettingTile(
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
                buildSettingsCard(cardColor, [
                  SwitchListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Enable Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: const Text(
                      "Enable sounds during therapy session",
                    ),
                    value: settings.notificationsEnabled,
                    onChanged: (val) {context.read<SettingsProvider>().toggleSound();},
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
                    value: context.watch<SettingsProvider>().isDarkMode,
                    onChanged: (val)  {context.read<SettingsProvider>().toggleTheme();},
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
                buildSettingsCard(cardColor, [
                  buildSettingTile(
                    icon: Icons.lock_outline,
                    iconColor: Colors.grey[700]!,
                    title: "Change Password",
                    subtitle: "Click to change your password",
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(height: 1),
                  buildSettingTile(
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
    );
  }





}
