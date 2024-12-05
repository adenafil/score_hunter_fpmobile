import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer_live_score/widgets/build_history_tab.dart';
import '../constants.dart';
import '../widgets/inplay_tab.dart';

class MyGuestScreen extends StatefulWidget {
  const MyGuestScreen({super.key});

  @override
  State<MyGuestScreen> createState() => _MyGuestScreenState();
}

class _MyGuestScreenState extends State<MyGuestScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Container(
              width: double.infinity,
              height: 72,
              padding: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: kAccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 52,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 17),
                        decoration: ShapeDecoration(
                          color: selectedIndex == 0
                              ? kPrimaryColor
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'In Play',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 52,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 17),
                        decoration: ShapeDecoration(
                          color: selectedIndex == 1
                              ? kPrimaryColor
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'History',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: selectedIndex == 0 ? const InPlayTab() : const HistoryTab(),
          ),
        ],
      ),
    );
  }
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
              "My Guess",
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
