import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/live_match_model.dart';

class LiveMatchData extends StatelessWidget {
  const LiveMatchData({
    super.key,
    required this.live,
  });

  final LiveMatch live;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 230,
        width: MediaQuery.of(context).size.width * 0.85,
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              live.stadium,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              'Week ${live.stageWeek.toString()}',
              style: const TextStyle(
                color: kSecondaryColor,
                fontSize: 10,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team Kiri (Home)
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              live.homeLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          live.homeTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Home',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${live.homeGoal} : ",
                                style: TextStyle(
                                  color: live.onTheWinner
                                      ? live.textColors
                                      : kPrimaryColor,
                                  fontSize: 24,
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: live.awayGoal.toString(),
                                style: TextStyle(
                                  color: live.onTheWinner
                                      ? kPrimaryColor
                                      : live.textColors,
                                  fontSize: 24,
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          live.getFormattedMatchTime(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontSize: 8,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Team Kanan (Away)
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              live.awayLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          live.awayTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Away',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD3D3D3),
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Betting Odds Section
            SizedBox(
              height: 31,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: ShapeDecoration(
                      color: kBackgroundColorDarken,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'W1',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '2.56',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: ShapeDecoration(
                      color: kBackgroundColorDarken,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'X',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 28),
                        Text(
                          '2.33',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: ShapeDecoration(
                      color: kBackgroundColorDarken,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'W2',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 19),
                        Text(
                          '1.37',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
