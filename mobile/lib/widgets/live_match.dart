import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      height: 230,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: live.color,
        borderRadius: BorderRadius.circular(35),
        image: live.backgroundImage,
      ),
      child: Column(
        children: [
          Text(
            live.stadium,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: live.textColors,
              letterSpacing: -1,
            ),
          ),
          Text(
            "Week 13",
            style: GoogleFonts.spaceGrotesk(
              color: live.textColors,
              letterSpacing: -1,
              fontSize: 11,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    live.homeLogo,
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    live.homeTitle.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                        color: live.textColors,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1),
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        color: live.textColors,
                        letterSpacing: -1),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              // Time and Score
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${live.time}'",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: live.textColors,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${live.homeGoal} : ",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: live.onTheWinner
                                ? kprimaryColor
                                : live.textColors,
                            shadows: [
                              Shadow(
                                blurRadius: 25.0,
                                color: Colors.black87.withOpacity(0.4),
                              ),
                            ],
                          ),
                        ),
                        TextSpan(
                          text: live.awayGoal.toString(),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: live.onTheWinner
                                ? live.textColors
                                : kprimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // for away team and logo
              const SizedBox(width: 20),
              Column(
                children: [
                  Image.asset(
                    live.awayLogo,
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    live.awayTitle.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                        color: live.textColors,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1),
                  ),
                  Text(
                    "Away",
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        color: live.textColors,
                        letterSpacing: -1),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
