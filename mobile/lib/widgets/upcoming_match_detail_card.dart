import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../model/up_coming_model.dart';

class UpcomingMatchDetailCard extends StatelessWidget {
  final UpcomingMatch upMatch;
  const UpcomingMatchDetailCard({super.key, required this.upMatch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: kAccentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stadium and Week Info
              Column(
                children: [
                  Text(
                    upMatch.stadium,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Week ${upMatch.stageWeek.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Teams and VS
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Home Team
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 64,
                              child: Image.network(
                                                        upMatch.homeLogo,
                        height: 45,
                        width: 45,
                        loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child; // Jika selesai loading, tampilkan gambar
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,

                                  ),
                                );
                        },
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              upMatch.homeTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Home',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // VS and Match Date & Time
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'VS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8), // Spacer
                            // Match Date and Time
                            Column(
                              children: [
                                Text(
  upMatch.date != null
      ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(upMatch.date!))
      : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  upMatch.time ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Away Team
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 64,
                              child: Image.network(
                                                        upMatch.awayLogo,
                        height: 45,
                        width: 45,
                        loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child; // Jika selesai loading, tampilkan gambar
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,

                                  ),
                                );
                        },
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              upMatch.awayTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Away',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 16),

              // Betting Odds
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOddsPill('W1', upMatch.odds['homeWin'].toString()),
                    const SizedBox(width: 16),
                    _buildOddsPill('X', upMatch.odds['draw'].toString()),
                    const SizedBox(width: 16),
                    _buildOddsPill('W2', upMatch.odds['awayWin'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOddsPill(String label, String odds) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: ShapeDecoration(
        color: kBackgroundColorDarken,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kSecondaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            odds,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
