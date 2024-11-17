import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../screens/match_detail_screen.dart';

class LiveMatchDetail extends StatelessWidget {
  const LiveMatchDetail({
    super.key,
    required this.widget,
  });

  final MatchDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      right: 24,
      left: 24,
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.liveMatch.color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -230,
              child: Transform.rotate(
                angle: 45,
                child: Opacity(
                    opacity: 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/img/cl.png",
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Text(
                    widget.liveMatch.stadium,
                    style: TextStyle(
                      fontSize: 15,
                      color: widget.liveMatch.textColors,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Image.asset(
                        widget.liveMatch.homeLogo,
                        width: 90,
                        height: 90,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffFFF4E5),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: kPrimaryColor,
                                  size: 10,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Live",
                                  style: GoogleFonts.spaceGrotesk(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.liveMatch.homeGoal.toString(),
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: widget.liveMatch.onTheWinner
                                        ? kPrimaryColor
                                        : widget.liveMatch.textColors,
                                  ),
                                ),
                                TextSpan(
                                  text: " : ${widget.liveMatch.awayGoal}",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: widget.liveMatch.onTheWinner
                                        ? widget.liveMatch.textColors
                                        : kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        widget.liveMatch.awayLogo,
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 20,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          right: 50,
                          left: 0,
                          top: 0,
                          bottom: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "ST",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: MediaQuery.of(context).size.width / 2 -
                              MediaQuery.of(context).size.width / 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              "HT",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -1,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              "FT",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black12,
                              ),
                            ),
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
