import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../controller/user_controller.dart';
import '../dbHelper/ApiService.dart';
import 'login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void dispose() {
    // Cleanup resources saat widget di-dispose oleh Flutter
    super.dispose();
  }

  Future<void> _logout() async {
    try {
      // Reset user data dan state
      setState(() {
        UserController.user = null;
      });

      // Proses logout
      await UserController.signOut();
      await ApiService().logoutUser();

      if (mounted) {
        // Clear navigation stack dan pindah ke login screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360;

    // Calculate responsive sizes
    final double avatarSize = screenSize.width * 0.2; // 20% of screen width
    final double statItemSize = screenSize.width * 0.17; // 17% of screen width
    final double horizontalPadding = screenSize.width * 0.05; // 5% of screen width

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenSize.height - MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: screenSize.height * 0.03,
              ),
              child: Column(
                children: [
                  // Profile Avatar
                  CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundImage: NetworkImage(UserController.user?.photoURL ?? ''),
                    onBackgroundImageError: (exception, stackTrace) {
                      // Handle error loading image
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.04),

                  // Stats Row with Wrap for smaller screens
                  Wrap(
                    spacing: screenSize.width * 0.03,
                    runSpacing: screenSize.width * 0.03,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatItem("Prediction", "99", statItemSize, isSmallScreen),
                      _buildStatItem("Win", "90", statItemSize, isSmallScreen),
                      _buildStatItem("Lose", "9", statItemSize, isSmallScreen),
                      _buildStatItem("Winrate", "89%", statItemSize, isSmallScreen),
                    ],
                  ),

                  SizedBox(height: screenSize.height * 0.04),

                  // Profile Info Cards
                  _buildInfoCard(
                    icon: Icons.person,
                    text: UserController.user?.displayName ?? 'Guest User',
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  _buildInfoCard(
                    icon: Icons.mail,
                    text: UserController.user?.email ?? 'Guest Email',
                    isSmallScreen: isSmallScreen,
                  ),

                  SizedBox(height: screenSize.height * 0.04),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: screenSize.height * 0.06,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4B4B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, double size, bool isSmallScreen) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF6C63FF),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 14 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 10 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String text,
    required bool isSmallScreen,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 15 : 20,
        vertical: isSmallScreen ? 12 : 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF282A4E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: isSmallScreen ? 20 : 24,
          ),
          SizedBox(width: isSmallScreen ? 10 : 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmallScreen ? 14 : 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize headerParts(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: kBackgroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
