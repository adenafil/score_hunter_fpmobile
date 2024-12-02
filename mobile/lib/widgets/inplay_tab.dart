import 'package:flutter/material.dart';
import '../constants.dart';

class InPlayTab extends StatefulWidget {
  const InPlayTab({super.key});

  @override
  State<InPlayTab> createState() => _InPlayTabState();
}

class _InPlayTabState extends State<InPlayTab> {
  // Dummy data untuk testing
  final List<Map<String, dynamic>> matches = [
    {
      'homeTeam': 'Arsenal F.C',
      'homeLogo': 'assets/img/arsenal.png',
      'homeScore': 2,
      'awayTeam': 'Manchester City',
      'awayLogo': 'assets/img/man_city.png',
      'awayScore': 1,
      'matchStatus': '1st half, time elapse: 44:55',
      'odds': '2.56',
      'statusLabel': 'MATCH IN PROGRESS',
      'halfTimeOdds': '1.75',
    },
    {
      'homeTeam': 'Chelsea F.C',
      'homeLogo': 'assets/img/chelsea.png',
      'homeScore': 1,
      'awayTeam': 'Liverpool F.C',
      'awayLogo': 'assets/img/liverpool.png',
      'awayScore': 3,
      'matchStatus': '1st half, time elapse: 40:12',
      'odds': '3.75',
      'statusLabel': 'MATCH IS OVER',
      'halfTimeOdds': '1.60',
    },
    {
      'homeTeam': 'Arsenal F.C',
      'homeLogo': 'assets/img/arsenal.png',
      'homeScore': 2,
      'awayTeam': 'Manchester City',
      'awayLogo': 'assets/img/man_city.png',
      'awayScore': 1,
      'matchStatus': '1st half, time elapse: 44:55',
      'odds': '2.56',
      'statusLabel': 'MATCH IN PROGRESS',
      'halfTimeOdds': '1.75',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MatchCard(
            homeTeam: match['homeTeam'],
            homeLogo: match['homeLogo'],
            homeScore: match['homeScore'],
            awayTeam: match['awayTeam'],
            awayLogo: match['awayLogo'],
            awayScore: match['awayScore'],
            matchStatus: match['matchStatus'],
            odds: match['odds'],
            statusLabel: match['statusLabel'],
            halfTimeOdds: match['halfTimeOdds'],
          ),
        );
      },
    );
  }
}

class MatchCard extends StatelessWidget {
  final String homeTeam;
  final String homeLogo;
  final int homeScore;
  final String awayTeam;
  final String awayLogo;
  final int awayScore;
  final String matchStatus;
  final String odds;
  final String statusLabel;
  final String halfTimeOdds;

  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.homeLogo,
    required this.homeScore,
    required this.awayTeam,
    required this.awayLogo,
    required this.awayScore,
    required this.matchStatus,
    required this.odds,
    required this.statusLabel,
    required this.halfTimeOdds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      width: MediaQuery.of(context).size.width * 0.85,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: kAccentColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const ShapeDecoration(
                    color: Color(0xFFD3C529),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        statusLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  matchStatus,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 10,
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Positioned(
            left: 24,
            top: 75,
            child: SizedBox(
              width: 313,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(homeLogo),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 60,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeTeam,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'HOME',
                                style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 10,
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 167),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (homeScore > awayScore)
                        Container(
                          width: 16,
                          height: 16,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(width: 6),
                      Text(
                        homeScore.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 211,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(homeLogo),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Odds',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 10,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      odds,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            top: 131,
            child: SizedBox(
              width: 313,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(awayLogo),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 95,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              awayTeam,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'AWAY',
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 10,
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 124),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (awayScore > homeScore)
                        Container(
                          width: 16,
                          height: 16,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(width: 6),
                      Text(
                        awayScore.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 191,
            child: Container(
              width: 313,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 249,
            top: 216,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: kBackgroundColorDarken,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '1st half time',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 10,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
