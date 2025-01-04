// class UpcomingMatch {
//   final String homeTitle;
//   final String awayTitle;
//   final String homeLogo;
//   final String awayLogo;
//   final String time;
//   final String date;
//   final bool isFavorite;
//
//   UpcomingMatch({
//     required this.homeTitle,
//     required this.awayTitle,
//     required this.homeLogo,
//     required this.awayLogo,
//     required this.time,
//     required this.date,
//     this.isFavorite = false,
//   });
//
//   factory UpcomingMatch.fromJson(Map<String, dynamic> json) {
//     return UpcomingMatch(
//       homeTitle: json['homeTeam']['name'],
//       awayTitle: json['awayTeam']['name'],
//       homeLogo: json['homeTeam']['logo'], // Periksa nama field untuk logo
//       awayLogo: json['awayTeam']['logo'], // Periksa nama field untuk logo
//       time: json['time'].split(' ')[1], // Ambil jam
//       date: json['time'].split(' ')[0], // Ambil tanggal
//     );
//   }
// }
