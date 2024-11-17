import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soccer_live_score/constants.dart';

class LiveMatchStats extends StatelessWidget {
  final int homeStats, awayStats;
  final String title;
  final double homeValue, awayValue;
  final bool isHomeWinner;
  const LiveMatchStats({
    super.key,
    required this.homeStats,
    required this.awayStats,
    required this.title,
    required this.homeValue,
    required this.awayValue,
    required this.isHomeWinner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeStats.toString(),
                style: GoogleFonts.spaceGrotesk(
                  color: isHomeWinner ? kPrimaryColor : kBackgroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                awayStats.toString(),
                style: GoogleFonts.spaceGrotesk(
                  color: !isHomeWinner ? kPrimaryColor : kBackgroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: LinearProgressIndicator(
                    value: homeValue,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(
                      isHomeWinner ? kPrimaryColor : kBackgroundColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LinearProgressIndicator(
                  value: awayValue,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation(
                    !isHomeWinner ? kPrimaryColor : kBackgroundColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
