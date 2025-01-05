import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final int onTheWinner;
  final Map<String, Map<String, dynamic>> votes;

  LiveMatch({
    required this.awayGoal,
    required this.homeGoal,
    required this.time,
    required this.awayLogo,
    required this.homeLogo,
    required this.awayTitle,
    required this.homeTitle,
    required this.stadium,
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
    required this.votes,
  });
  
  
  factory LiveMatch.fromJson(Map<String, dynamic> json) {
  return LiveMatch(
    awayGoal: json['awayGoal']?.toString() ?? '0',
    homeGoal: json['homeGoal']?.toString() ?? '0',
    time: json['time'] ?? '',
    awayLogo: json['awayLogo'] ?? '',
    homeLogo: json['homeLogo'] ?? '',
    awayTitle: json['awayTitle'] ?? '',
    homeTitle: json['homeTitle'] ?? '',
    stadium: json['stadium'] ?? 'Unknown Stadium',
    stageWeek: json['stageWeek']?.toString() ?? '0',
    matchTime: json['matchTime'] ?? '',
    awayGoalScorers: List<String>.from(json['awayGoalScorers'] ?? []),
    homeGoalScorers: List<String>.from(json['homeGoalScorers'] ?? []),
    odds: Map<String, String>.from(json['odds'] ?? {}),
    shotOnTarget: json['shotOnTarget']?.toString() ?? '0',
    possession: json['possession']?.toString() ?? '0',
    yellowCard: json['yellowCard']?.toString() ?? '0',
    redCard: json['redCard']?.toString() ?? '0',
    corner: json['corner']?.toString() ?? '0',
    color: json['color']?.toString() ?? '0xff202020',
    textColors: json['textColors'] ?? '#ffffff',
    backgroundImage: json['backgroundImage'] ?? '',
    onTheWinner: json['onTheWinner'] ?? false,
    votes: Map<String, Map<String, dynamic>>.from(
      (json['votes'] ?? {}).map(
        (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
      ),
    ),
  );
}


}


class LiveMatchService {
  Future<List<LiveMatch>> fetchLiveMatches() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.101:3000/api/startedmatch'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-TOKEN': "admin",
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // Memastikan data ada dan dalam format yang diharapkan
        if (decodedResponse != null &&
            decodedResponse is Map<String, dynamic> &&
            decodedResponse['data'] is List) {
          // Memproses hanya data yang valid
          final matches = (decodedResponse['data'] as List)
              .map((match) {
                try {
                  return LiveMatch.fromJson(match);
                } catch (e) {
                  // Abaikan elemen yang tidak valid
                  return null;
                }
              })
              .whereType<LiveMatch>()
              .toList();

          return matches;
        } else {
          throw Exception("Invalid data format from API");
        }
      } else {
        throw Exception('Failed to load live matches');
      }
    } catch (e) {
      throw Exception('Error fetching live matches: $e');
    }
  }
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
    onTheWinner: 11,
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
    onTheWinner: 11,
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
    onTheWinner: 11,
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
