class UpcomingMatch {
  final String awayLogo;
  final String awayTitle;
  final String homeLogo;
  final String homeTitle;
  final String? date;
  final String? time;
  final bool isFavorite;
  final String stadium;
  final int stageWeek;
  final Map<String, String> odds;
  final Map<String, Map<String, dynamic>> votes;

  UpcomingMatch({
    required this.awayLogo,
    required this.awayTitle,
    required this.homeLogo,
    required this.homeTitle,
    this.date,
    this.time,
    required this.isFavorite,
    required this.stadium,
    required this.stageWeek,
    required this.odds,
    required this.votes,
  });

  factory UpcomingMatch.fromJson(Map<String, dynamic> json) {
    return UpcomingMatch(
      awayLogo: json['awayLogo'],
      awayTitle: json['awayTitle'],
      homeLogo: json['homeLogo'],
      homeTitle: json['homeTitle'] ?? '', // default jika kosong
      date: json['date'],
      time: json['time'], // Tambahkan jika ada waktu
      isFavorite: json['isFavorite'] ?? false,
      stadium: json['stadium'],
      stageWeek: int.tryParse(json['stageWeek'] ?? '0') ?? 0,
      odds: Map<String, String>.from(json['odds']),
      votes: Map<String, Map<String, dynamic>>.from(
        (json['votes'] as Map).map(
          (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
        ),
      ),
    );
  }
}

List<UpcomingMatch> upcomingMatches = [
  UpcomingMatch(
    awayLogo: "assets/img/brighton.png",
    awayTitle: "Brighton & Hove Albion",
    homeLogo: "assets/img/afc_bournemouth.png",
    homeTitle: "AFC Bournemouth",
    date: "11 Nov",
    time: "02:35 AM",
    isFavorite: true,
    stadium: "Vitality Stadium",
    stageWeek: 12,
    odds: {
      "homeWin": "2.10",
      "draw": "3.20",
      "awayWin": "1.90",
    },
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1000,
        "percentage": {
          "homeTeam": "45.0",
          "draw": "30.0",
          "awayTeam": 25.0,
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
  UpcomingMatch(
    awayLogo: "assets/img/nottingham_forest.png",
    awayTitle: "Nottingham Forest",
    homeLogo: "assets/img/arsenal.png",
    homeTitle: "Arsenal F.C.",
    date: "23 Nov",
    time: "10:00 PM",
    isFavorite: true,
    stadium: "Emirates Stadium",
    stageWeek: 13,
    odds: {
      "homeWin": "1.80",
      "draw": "3.50",
      "awayWin": "2.20",
    },
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1500,
        "percentage": {
          "homeTeam": 60.0,
          "draw": 25.0,
          "awayTeam": 15.0,
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
  UpcomingMatch(
    awayLogo: "assets/img/crystal_palace.png",
    awayTitle: "Crystal Palace",
    homeLogo: "assets/img/aston_villa.png",
    homeTitle: "Aston Villa",
    date: "24 Nov",
    time: "04:35 AM",
    isFavorite: true,
    stadium: "Emirates Stadium",
    stageWeek: 13,
    odds: {
      "homeWin": "1.80",
      "draw": "3.50",
      "awayWin": "2.20",
    },
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1500,
        "percentage": {
          "homeTeam": 60.0,
          "draw": 25.0,
          "awayTeam": 15.0,
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
  UpcomingMatch(
    awayLogo: "assets/img/wolves.png",
    awayTitle: "Wolves",
    homeLogo: "assets/img/fulham.png",
    homeTitle: "Fulham",
    date: "24 Nov",
    time: "02:35 AM",
    isFavorite: true,
    stadium: "Emirates Stadium",
    stageWeek: 13,
    odds: {
      "homeWin": "1.80",
      "draw": "3.50",
      "awayWin": "2.20",
    },
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1500,
        "percentage": {
          "homeTeam": 60.0,
          "draw": 25.0,
          "awayTeam": 15.0,
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
  UpcomingMatch(
    awayLogo: "assets/img/tottenham.png",
    awayTitle: "Tottenham Hotspur",
    homeLogo: "assets/img/man_city.png",
    homeTitle: "Manchester City",
    date: "24 Nov",
    time: "12:30 AM",
    isFavorite: true,
    stadium: "Emirates Stadium",
    stageWeek: 13,
    odds: {
      "homeWin": "1.80",
      "draw": "3.50",
      "awayWin": "2.20",
    },
    votes: {
      "regularTime": {
        "categoryName": "Regular Time",
        "totalVotes": 1500,
        "percentage": {
          "homeTeam": 60.0,
          "draw": 25.0,
          "awayTeam": 15.0,
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
