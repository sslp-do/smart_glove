import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smart_glove/core/models/assets.dart';
import 'package:smart_glove/ui/login/screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF2C5364),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Image.asset(AppAssets.background, fit: BoxFit.cover),
          ),

         /* Opacity(
            opacity: 0.2,
            child: Image.asset(AppAssets.gloveHand,fit: BoxFit.cover)
                .animate()
                .fade(duration: 900.ms)
             //   .scale(delay: 400.ms),
          ),*/

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                /*  const Icon(Icons.back_hand_rounded, size: 100, color: Colors.cyanAccent)
                    .animate()
                    .fade(duration: 600.ms)
                    .scale(delay: 200.ms),*/
                     Image.asset(AppAssets.gloveHand,scale: 5,),
               const SizedBox(height: 20),


                Text(
                      "SMART REHABILITATION GLOVE",
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                    )
                    .animate()
                    .fade(delay: 400.ms, duration: 900.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 10),

                Text(
                  "Smart Rehabilitation for a Better Future",
                  style: TextStyle(color: Colors.grey[300], fontSize: 16),
                ).animate().fade(delay: 1000.ms),

                const SizedBox(height: 60),

                SizedBox(
                  width: 200,
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.white10,
                    color: Colors.cyanAccent,
                    minHeight: 3,
                  ),
                ).animate().fade(delay: 1500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
