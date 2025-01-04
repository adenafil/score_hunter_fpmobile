import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/controller/user_controller.dart';
import 'package:soccer_live_score/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Full width illustration
          Positioned(
            top: 64,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/img/login_img.png',
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),

          // Main content with SafeArea
          SafeArea(
            child: Column(
              children: [
                // Spacer to push content below illustration
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),

                const SizedBox(height: 96),

                // Welcome text
                const Text(
                  "Welcome to\nScore Hunter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  "Let's make score-hunting fun\nand exciting!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),

                const Spacer(),

                // Google Auth Implement
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await UserController.loginWithGoogle();

                        if (user != null && mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AppMainScreen(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (error) {
                        print(error.message);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          error.message ?? "Something went wrong",
                        )));
                      } catch (error) {
                        print(error);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          error.toString(),
                        )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/img/google_icon.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Continue with Google",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
