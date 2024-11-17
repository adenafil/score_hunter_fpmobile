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
              color: kAccentColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4.5),
                  color: upMatch.isFavorite ? kPrimaryColor : Colors.white,
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
                    const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 10,
                        color: kTransparentWhite,
                      ),
                    ),
                    Text(
                      upMatch.homeTitle,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      upMatch.time,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      upMatch.date,
                      style: const TextStyle(
                        fontSize: 10,
                        color: kPrimaryColor,
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
                    const Text(
                      "Away",
                      style: TextStyle(fontSize: 11, color: kTransparentWhite),
                    ),
                    Text(
                      upMatch.awayTitle,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          // Positioned(
          //   top: 12,
          //   left: 12,
          //   child: Icon(
          //     Icons.star,
          //     color: upMatch.isFavorite ? kPrimaryColor : Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
