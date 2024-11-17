import 'package:flutter/material.dart';

class LiveMatch {
  final int awayGoal;
  final int homeGoal;
  final int time; // time of the match (in minutes)
  final String awayLogo;
  final String homeLogo;
  final String awayTitle;
  final String homeTitle;
  final String stadium;
  final int shotOnTarget, possession, yelloCard, redCard, corner;
  final Color color;
  final Color textColors;
  final DecorationImage backgroundImage;
  bool onTheWinner;
// i have create a simple data model for this video
// all the source code link is  in description
  LiveMatch({
    required this.awayGoal,
    required this.homeGoal,
    required this.time,
    required this.stadium,
    required this.awayLogo,
    required this.homeLogo,
    required this.awayTitle,
    required this.homeTitle,
    required this.shotOnTarget,
    required this.possession,
    required this.yelloCard,
    required this.redCard,
    required this.corner,
    required this.color,
    required this.textColors,
    required this.onTheWinner,
    required this.backgroundImage,
  });
}

List<LiveMatch> liveMatches = [
  LiveMatch(
    awayGoal: 1,
    homeGoal: 2,
    stadium: "Etihad Stadium",
    time: 45, // First half time elapsed
    awayLogo: "assets/img/man_city.png",
    homeLogo: "assets/img/arsenal.png",
    awayTitle: "Manchester City",
    homeTitle: "Arsenal F.C.",
    color: const Color(0xffe4e4e4),
    textColors: Colors.black,
    onTheWinner: false,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.2,
    ),
    shotOnTarget: 5, // Placeholder, isi dengan data yang sesuai
    possession: 60, // Placeholder, isi dengan data yang sesuai
    yelloCard: 2, // Placeholder, isi dengan data yang sesuai
    redCard: 0, // Placeholder, isi dengan data yang sesuai
    corner: 6, // Placeholder, isi dengan data yang sesuai
  ),
  LiveMatch(
    awayGoal: 0,
    homeGoal: 2,
    stadium: "King Power Stadium",
    time: 93, // Second half time elapsed
    awayLogo: "assets/img/leicester_city.png",
    homeLogo: "assets/img/chelsea.png",
    awayTitle: "Leicester City",
    homeTitle: "Chelsea",
    color: const Color(0xff202020),
    textColors: Colors.white,
    onTheWinner: false,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.3,
    ),
    shotOnTarget: 7, // Placeholder, isi dengan data yang sesuai
    possession: 55, // Placeholder, isi dengan data yang sesuai
    yelloCard: 3, // Placeholder, isi dengan data yang sesuai
    redCard: 0, // Placeholder, isi dengan data yang sesuai
    corner: 4, // Placeholder, isi dengan data yang sesuai
  ),
  LiveMatch(
    awayGoal: 3,
    homeGoal: 0,
    stadium: "Old Trafford Stadium",
    time: 45, // First half time elapsed
    awayLogo: "assets/img/man_united.png",
    homeLogo: "assets/img/liverpool.png",
    awayTitle: "Manchester United",
    homeTitle: "Liverpool F.C.",
    color: const Color(0xffe4e4e4),
    textColors: Colors.black,
    onTheWinner: true,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.2,
    ),
    shotOnTarget: 8, // Placeholder, isi dengan data yang sesuai
    possession: 50, // Placeholder, isi dengan data yang sesuai
    yelloCard: 1, // Placeholder, isi dengan data yang sesuai
    redCard: 0, // Placeholder, isi dengan data yang sesuai
    corner: 5, // Placeholder, isi dengan data yang sesuai
  ),
];
