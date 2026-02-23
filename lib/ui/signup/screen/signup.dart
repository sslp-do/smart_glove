import 'package:flutter/material.dart';
import 'package:smart_glove/models/assets.dart';

class PatientSignUpScreen extends StatefulWidget {
  const PatientSignUpScreen({super.key});

  @override
  State<PatientSignUpScreen> createState() => _PatientSignUpScreenState();
}

class _PatientSignUpScreenState extends State<PatientSignUpScreen> {
  bool obscurePassword = true;
  String selectedHand = 'Right';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Row(
        children: [
         //Left Side: Visual Side

          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: const Color(0xFF0F2027).withOpacity(0.85),
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Start Your\nRecovery Journey",
                      style: theme.textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Create an account to connect with your therapist and track your smart glove sessions in real-time.",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
//Right Side: Registration Form

          Expanded(
            flex: 5,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Create Patient Account", style: theme.textTheme.displayMedium, textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Text("Please fill in your details", style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
                      const SizedBox(height: 40),


                      _buildTextField(theme, "Full Name", Icons.person_outline, "e.g., Sarah Ahmad"),
                      const SizedBox(height: 20),

                      _buildTextField(theme, "Email Address", Icons.email_outlined, "e.g., patient@email.com"),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: _buildTextField(theme, "Age", Icons.calendar_today, "e.g., 45")),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Affected Hand", style: theme.textTheme.titleSmall),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedHand,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.front_hand),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  items: ['Right', 'Left'].map((String value) {
                                    return DropdownMenuItem<String>(value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() => selectedHand = newValue!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),


                      Text("Password", style: theme.textTheme.titleSmall),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Create a strong password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => obscurePassword = !obscurePassword),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),


                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Create Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(ThemeData theme, String label, IconData icon, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}