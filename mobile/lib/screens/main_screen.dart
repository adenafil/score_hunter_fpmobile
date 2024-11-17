import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/screens/app_home_screen.dart';
import 'package:soccer_live_score/screens/login_screen.dart';
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
    IconsaxPlusLinear.calendar,
    IconsaxPlusLinear.chart_square,
    IconsaxPlusLinear.user_square,
  ];

  final titles = [
    "Home",
    "Calendar",
    "Standing",
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
      const Scaffold(),
      const Scaffold(),
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
        height: 80,
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.015),
              blurRadius: 8,
              spreadRadius: 5,
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            4,
            (index) => MyBottomNavBarItems(
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? kPrimaryColor : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey.shade400,
            ),
            if (isActive)
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}
