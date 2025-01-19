import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';

import '../constants.dart';
import '../model/up_coming_model.dart';

class UpComingMatches extends StatelessWidget {
  const UpComingMatches({
    super.key,
    required this.upMatch,
  });

  
  final UpcomingMatch upMatch ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              bottom: 8,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        upMatch.homeLogo,
                                                      errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/img/logo-team-default.png',
                                  height: 64,
                                );
                              },

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
                      const Text(
                        textAlign: TextAlign.center,
                        "Home",
                        style: TextStyle(
                          fontSize: 10,
                          color: kTransparentWhite,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        upMatch.homeTitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                       upMatch.date != null ? DateFormat('HH:mm').format(DateTime.parse(upMatch.date!)) : "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
  upMatch.date != null
      ? DateFormat('dd MMM').format(DateTime.parse(upMatch.date!))
      : "",
                        style: const TextStyle(
                          fontSize: 10,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Image.network(
                        upMatch.awayLogo,
                                                      errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/img/logo-team-default.png',
                                  height: 64,
                                );
                              },

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
                      const Text(
                        textAlign: TextAlign.center,
                        "Away",
                        style:
                            TextStyle(fontSize: 11, color: kTransparentWhite),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        upMatch.awayTitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
