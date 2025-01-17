import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:soccer_live_score/model/UserProfile.dart';

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
  final ApiService _apiService = ApiService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userData = await _apiService.fetchUserData('ade');
      setState(() {
        UserController.userProfile = UserProfile.fromJson(userData['data']); // Assign data profil
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      setState(() {
        UserController.user = null;
        UserController.userProfile = null;
      });

      await UserController.signOut();
      final cacheManager = DefaultCacheManager();
      await cacheManager.removeFile(ApiService.cacheKeyProfile); // Hapus cache saat logout

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

@override
Widget build(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final bool isSmallScreen = screenSize.width < 360;
  final double avatarSize = screenSize.width * 0.2;
  final double statItemSize = screenSize.width * 0.17;
  final double horizontalPadding = screenSize.width * 0.05;

  if (_isLoading) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

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
                CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundImage: NetworkImage(UserController.userProfile?.photoURL ?? ''),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle error loading image
                  },
                ),
                SizedBox(height: screenSize.height * 0.04),
Wrap(
  spacing: screenSize.width * 0.03,
  runSpacing: screenSize.width * 0.03,
  alignment: WrapAlignment.center,
  children: [
    _buildStatItem("Prediction", "${UserController.userProfile?.statistic["total_guess"] ?? 0}", statItemSize, isSmallScreen),
    _buildStatItem("Win",  "${UserController.userProfile?.statistic["total_win"] ?? 0}", statItemSize, isSmallScreen),
    _buildStatItem("Lose",  "${UserController.userProfile?.statistic["total_lose"] ?? 0}", statItemSize, isSmallScreen),
    _buildStatItem("Winrate",  "${(UserController.userProfile?.statistic["win_rate_percentage"] ?? 0).toStringAsFixed(2)}%", statItemSize, isSmallScreen),
  ],
),
                SizedBox(height: screenSize.height * 0.04),
                _buildInfoCard(
                  icon: Icons.person,
                  text: UserController.userProfile?.displayName ?? 'Guest User',
                  isSmallScreen: isSmallScreen,
                ),
                SizedBox(height: screenSize.height * 0.02),
                _buildInfoCard(
                  icon: Icons.mail,
                  text: UserController.userProfile?.email ?? 'Guest Email',
                  isSmallScreen: isSmallScreen,
                ),
                SizedBox(height: screenSize.height * 0.04),
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
                // Tambahkan SizedBox untuk memberikan ruang tambahan di bagian bawah
                SizedBox(height: screenSize.height * 0.04),
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
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1, // Batasi teks ke 1 baris
            overflow: TextOverflow.ellipsis, // Tambahkan ellipsis jika teks terlalu panjang
          ),
        ),
        SizedBox(height: 4), // Jarak antara value dan label
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 8 : 10,
            ),
            maxLines: 1, // Batasi teks ke 1 baris
            overflow: TextOverflow.ellipsis, // Tambahkan ellipsis jika teks terlalu panjang
          ),
        ),
      ],
    ),
  );
}  Widget _buildInfoCard({
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
