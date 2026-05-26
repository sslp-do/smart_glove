import 'package:flutter/material.dart';
import 'package:smart_glove/core/models/assets.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/screens/patient_dashboard.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/screen/therapist_dashboard.dart';

import 'package:smart_glove/ui/signup/screen/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPatientLogin = true;

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
     //Visual Side
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF0F2027).withOpacity(0.7),
                      const Color(0xFF2C5364).withOpacity(0.9),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.gloveHand,),
                    /*const Icon(Icons.back_hand_rounded, size: 60, color: Colors.cyanAccent),*/
                    const SizedBox(height: 40),
                    Text(
                      "SMART REHABILITATION GLOVE",
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Smart Rehabilitation.\nEmpowering your recovery journey every step of the way.",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Registration Form
          Expanded(
            flex: 5,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome Back",
                      style: theme.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Please enter your details to sign in",
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                 //Role Switcher
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          _buildRoleButton(title: "Patient", isSelected: isPatientLogin, onTap: () => setState(() => isPatientLogin = true)),
                          _buildRoleButton(title: "Therapist", isSelected: !isPatientLogin, onTap: () => setState(() => isPatientLogin = false)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),


                    Text("Email Address", style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "e.g., example@email.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),


                    Text("Password", style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => obscurePassword = !obscurePassword),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Forgot Password?", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        if (isPatientLogin) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  PatientDashboard()));
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  TherapistDashboard()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Sign In", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                    ),
                    const SizedBox(height: 20),

                    if (isPatientLogin)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: theme.textTheme.bodyMedium),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PatientSignUpScreen()),
                              );
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton({required String title, required bool isSelected, required VoidCallback onTap}) {
    final primaryColor = Theme.of(context).primaryColor;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: primaryColor.withOpacity(0.5)) : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primaryColor : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}