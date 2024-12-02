import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/screens/app_home_screen.dart';
import 'package:soccer_live_score/screens/login_screen.dart';
import 'package:soccer_live_score/screens/my_guest_screen.dart';
import '../controller/user_controller.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currentTab = 0;

  final icons = [
    IconsaxPlusLinear.home,
    IconsaxPlusLinear.chart_square,
    IconsaxPlusLinear.coin,
    IconsaxPlusLinear.user_square,
  ];

  final titles = [
    "Home",
    "Leaderboard",
    "My Guess",
    "Profile",
  ];

  Future<void> _logout() async {
    await UserController.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const AppHomeScreen(),
      const Scaffold(
        body: Center(
          child: Text(
            "Ini Leaderboard Screen\nYa Maniez🤗",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
      const MyGuestScreen(),
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                foregroundImage:
                    NetworkImage(UserController.user?.photoURL ?? ''),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                UserController.user?.displayName ?? 'Guest User',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: kBackgroundColorDarken,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.015),
              blurRadius: 8,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: MyBottomNavBarItems(
                  title: titles[index],
                  isActive: currentTab == index,
                  onTab: () => setState(() {
                    currentTab = index;
                  }),
                  icon: icons[index],
                ),
              ),
            ),
          ),
        ),
      ),
      body: screens[currentTab],
    );
  }
}

class MyBottomNavBarItems extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function() onTab;
  final IconData icon;

  const MyBottomNavBarItems({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTab,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 80),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? kPrimaryColor50 : kBackgroundColorDarken,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : kTransparentWhite,
                ),
                Offstage(
                  offstage: !isActive,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                if (!isActive)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: kTransparentWhite, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
