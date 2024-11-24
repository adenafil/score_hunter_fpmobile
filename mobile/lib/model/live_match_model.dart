import 'package:flutter/material.dart';

class LiveMatch {
  final int awayGoal;
  final int homeGoal;
  final int time; // Time elapsed (in minutes)
  final String awayLogo;
  final String homeLogo;
  final String awayTitle;
  final String homeTitle;
  final String stadium;
  final int stageWeek; // Week number
  final DateTime matchTime; // Match date and time
  final List<String> awayGoalScorers; // Scorers for away team
  final List<String> homeGoalScorers; // Scorers for home team
  final Map<String, double> odds; // Betting odds (W1, X, W2)
  final int shotOnTarget;
  final int possession; // Percentage
  final int yellowCard;
  final int redCard;
  final int corner;
  final Color color; // Background color
  final Color textColors; // Text color
  final DecorationImage backgroundImage; // Background image
  final bool onTheWinner; // Indicates if the home team is winning

  LiveMatch({
    required this.awayGoal,
    required this.homeGoal,
    required this.time,
    required this.stadium,
    required this.awayLogo,
    required this.homeLogo,
    required this.awayTitle,
    required this.homeTitle,
    required this.stageWeek,
    required this.matchTime,
    required this.awayGoalScorers,
    required this.homeGoalScorers,
    required this.odds,
    required this.shotOnTarget,
    required this.possession,
    required this.yellowCard,
    required this.redCard,
    required this.corner,
    required this.color,
    required this.textColors,
    required this.backgroundImage,
    required this.onTheWinner,
  });

  // Method to get formatted match time
  String getFormattedMatchTime() {
    int minutes = time; // Time in minutes
    int seconds = (minutes * 60) %
        60; // Calculating seconds (can be customized if needed)
    String half =
        minutes < 45 ? "1st" : "2nd"; // Determine first or second half
    return '$half half, time elapse: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
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
    stageWeek: 12,
    matchTime: DateTime(2024, 11, 24, 20, 30),
    awayGoalScorers: ["Haaland (25')"],
    homeGoalScorers: ["G. Jesus (17')", "Saka (43')"],
    odds: {
      "homeWin": 2.56, // W1
      "draw": 2.33, // X
      "awayWin": 1.37, // W2
    },
    shotOnTarget: 5,
    possession: 60,
    yellowCard: 2,
    redCard: 0,
    corner: 6,
    color: const Color(0xffe4e4e4),
    textColors: Colors.white,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.2,
    ),
    onTheWinner: false,
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
    stageWeek: 12,
    matchTime: DateTime(2024, 11, 24, 22, 15),
    awayGoalScorers: [],
    homeGoalScorers: ["Pedro Neto (57')", "Sancho (85')"],
    odds: {
      "homeWin": 1.95, // W1
      "draw": 3.10, // X
      "awayWin": 4.20, // W2
    },
    shotOnTarget: 7,
    possession: 55,
    yellowCard: 3,
    redCard: 0,
    corner: 4,
    color: const Color(0xff202020),
    textColors: Colors.white,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.3,
    ),
    onTheWinner: false,
  ),
  LiveMatch(
    awayGoal: 3,
    homeGoal: 1,
    stadium: "Old Trafford Stadium",
    time: 45, // First half time elapsed
    awayLogo: "assets/img/man_united.png",
    homeLogo: "assets/img/liverpool.png",
    awayTitle: "Manchester United",
    homeTitle: "Liverpool F.C.",
    stageWeek: 12,
    matchTime: DateTime(2024, 11, 24, 18, 0),
    awayGoalScorers: ["Rashford (14')", "Bruno (30')", "Garnacho (43')"],
    homeGoalScorers: ["M. Salah (27')"],
    odds: {
      "homeWin": 3.00, // W1
      "draw": 2.75, // X
      "awayWin": 2.00, // W2
    },
    shotOnTarget: 8,
    possession: 50,
    yellowCard: 1,
    redCard: 0,
    corner: 5,
    color: const Color(0xffe4e4e4),
    textColors: Colors.white,
    backgroundImage: const DecorationImage(
      image: AssetImage("assets/img/pl.png"),
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      opacity: 0.2,
    ),
    onTheWinner: true,
  ),
];
