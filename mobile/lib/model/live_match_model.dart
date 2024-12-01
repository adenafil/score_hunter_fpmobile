import 'package:flutter/material.dart';

class LiveMatch {
  final int awayGoal;
  final int homeGoal;
  final int time;
  final String awayLogo;
  final String homeLogo;
  final String awayTitle;
  final String homeTitle;
  final String stadium;
  final int stageWeek;
  final DateTime matchTime;
  final List<String> awayGoalScorers;
  final List<String> homeGoalScorers;
  final Map<String, double> odds;
  final int shotOnTarget;
  final int possession;
  final int yellowCard;
  final int redCard;
  final int corner;
  final Color color;
  final Color textColors;
  final DecorationImage backgroundImage;
  final bool onTheWinner;

  // New fields for voting
  final Map<String, Map<String, dynamic>> votes; // Votes for each category

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
    required this.votes, // New parameter
  });

  // Method to get formatted match time
  String getFormattedMatchTime() {
    int minutes = time;
    int seconds = (minutes * 60) % 60;
    String half = minutes < 45 ? "1st" : "2nd";
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
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1353,
        "percentage": {
          "homeTeam": 11.0,
          "draw": 7.0,
          "awayTeam": 82.0,
        },
      },
      "firstHalfTime": {
        "categoryName": "1st Half Time",
        "totalVotes": 800,
        "percentage": {
          "homeTeam": 30.0,
          "draw": 50.0,
          "awayTeam": 20.0,
        },
      },
      "secondHalfTime": {
        "categoryName": "2nd Half Time",
        "totalVotes": 600,
        "percentage": {
          "homeTeam": 40.0,
          "draw": 35.0,
          "awayTeam": 25.0,
        },
      },
      "firstToHappen": {
        "categoryName": "First to Happen",
        "totalVotes": 400,
        "percentage": {
          "homeTeam": 45.0,
          "draw": 15.0,
          "awayTeam": 40.0,
        },
      },
    },
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
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 2055,
        "percentage": {
          "homeTeam": 27.0,
          "draw": 15.0,
          "awayTeam": 58.0,
        },
      },
      "firstHalfTime": {
        "categoryName": "1st Half Time",
        "totalVotes": 800,
        "percentage": {
          "homeTeam": 30.0,
          "draw": 50.0,
          "awayTeam": 20.0,
        },
      },
      "secondHalfTime": {
        "categoryName": "2nd Half Time",
        "totalVotes": 600,
        "percentage": {
          "homeTeam": 40.0,
          "draw": 35.0,
          "awayTeam": 25.0,
        },
      },
      "firstToHappen": {
        "categoryName": "First to Happen",
        "totalVotes": 400,
        "percentage": {
          "homeTeam": 45.0,
          "draw": 15.0,
          "awayTeam": 40.0,
        },
      },
    },
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
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 2055,
        "percentage": {
          "homeTeam": 27.0,
          "draw": 15.0,
          "awayTeam": 58.0,
        },
      },
      "firstHalfTime": {
        "categoryName": "1st Half Time",
        "totalVotes": 800,
        "percentage": {
          "homeTeam": 30.0,
          "draw": 50.0,
          "awayTeam": 20.0,
        },
      },
      "secondHalfTime": {
        "categoryName": "2nd Half Time",
        "totalVotes": 600,
        "percentage": {
          "homeTeam": 40.0,
          "draw": 35.0,
          "awayTeam": 25.0,
        },
      },
      "firstToHappen": {
        "categoryName": "First to Happen",
        "totalVotes": 400,
        "percentage": {
          "homeTeam": 45.0,
          "draw": 15.0,
          "awayTeam": 40.0,
        },
      },
    },
  ),
];
