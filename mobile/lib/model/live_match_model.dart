import 'package:flutter/material.dart';

class LiveMatch {
  final String awayGoal;
  final String homeGoal;
  final String time;
  final String awayLogo;
  final String homeLogo;
  final String awayTitle;
  final String homeTitle;
  final String stadium;
  final String stageWeek;
  final String matchTime;
  final List<String> awayGoalScorers;
  final List<String> homeGoalScorers;
  final Map<String, String> odds;
  final String shotOnTarget;
  final String possession;
  final String yellowCard;
  final String redCard;
  final String corner;
  final String color;
  final String textColors;
  final String backgroundImage;
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

}

List<LiveMatch> liveMatches = [
  LiveMatch(
    awayGoal: "1",
    homeGoal: "2",
    stadium: "Etihad Stadium",
    time: "45", // First half time elapsed
    awayLogo: "assets/img/man_city.png",
    homeLogo: "assets/img/arsenal.png",
    awayTitle: "Manchester City",
    homeTitle: "Arsenal F.C.",
    stageWeek: "1",
    matchTime: "2024-03-23",
    awayGoalScorers: ["Haaland (25')"],
    homeGoalScorers: ["G. Jesus (17')", "Saka (43')"],
    odds: {
      "homeWin": "2.56", // W1
      "draw": "2.33", // X
      "awayWin": "1.37", // W2
    },
    shotOnTarget: "5",
    possession: "60",
    yellowCard: "2",
    redCard: "0",
    corner: "6",
    color: "0xffe4e4e4",
    textColors: "#ffffff",
    backgroundImage: "assets/img/pl.png",
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
    awayGoal: "0",
    homeGoal: "2",
    stadium: "King Power Stadium",
    time: "93", // Second half time elapsed
    awayLogo: "assets/img/leicester_city.png",
    homeLogo: "assets/img/chelsea.png",
    awayTitle: "Leicester City",
    homeTitle: "Chelsea",
    stageWeek: "12",
    matchTime: "2024-03-02",
    awayGoalScorers: [],
    homeGoalScorers: ["Pedro Neto (57')", "Sancho (85')"],
    odds: {
      "homeWin": "1.95", // W1
      "draw": "3.10", // X
      "awayWin": "4.20", // W2
    },
    shotOnTarget: "7",
    possession: "55",
    yellowCard: "3",
    redCard: "0",
    corner: "4",
    color: "#000000",
    textColors: "#ffffff",
    backgroundImage: "assets/img/pl.png",
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
    awayGoal: "3",
    homeGoal: "1",
    stadium: "Old Trafford Stadium",
    time: "45", // First half time elapsed
    awayLogo: "assets/img/man_united.png",
    homeLogo: "assets/img/liverpool.png",
    awayTitle: "Manchester United",
    homeTitle: "Liverpool F.C.",
    stageWeek: "12",
    matchTime: "2024-03-02",
    awayGoalScorers: ["Rashford (14')", "Bruno (30')", "Garnacho (43')"],
    homeGoalScorers: ["M. Salah (27')"],
    odds: {
      "homeWin": "3.00", // W1
      "draw": "2.75", // X
      "awayWin": "2.00", // W2
    },
    shotOnTarget: "8",
    possession: "50",
    yellowCard: "1",
    redCard: "0",
    corner: "5",
    color: "#0xffe4e4e4",
    textColors: "#ffffff",
    backgroundImage: "assets/img/pl.png",
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
