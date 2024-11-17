import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../model/up_coming_model.dart';

class UpComingMatches extends StatelessWidget {
  const UpComingMatches({
    super.key,
    required this.upMatch,
  });

  final UpcomingMatch upMatch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4.5),
                  color: upMatch.isFavorite ? kPrimaryColor : Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      upMatch.homeLogo,
                      height: 45,
                      width: 45,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      upMatch.homeTitle,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        letterSpacing: -1,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      upMatch.time,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        letterSpacing: -1,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      upMatch.date,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Image.asset(
                      upMatch.awayLogo,
                      height: 45,
                      width: 45,
                    ),
                    Text(
                      "Away",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      upMatch.awayTitle,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        letterSpacing: -1,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Icon(
              Icons.star,
              color: upMatch.isFavorite ? kPrimaryColor : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
