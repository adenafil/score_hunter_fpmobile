class UpcomingMatch {
  final String awayLogo;
  final String awayTitle;
  final String homeLogo;
  final String homeTitle;
  final String date;
  final String time;
  final bool isFavorite;

  UpcomingMatch({
    required this.awayLogo,
    required this.awayTitle,
    required this.homeLogo,
    required this.homeTitle,
    required this.date,
    required this.time,
    required this.isFavorite,
  });
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
  ),
  UpcomingMatch(
    awayLogo: "assets/img/nottingham_forest.png",
    awayTitle: "Nottingham Forest",
    homeLogo: "assets/img/arsenal.png",
    homeTitle: "Arsenal F.C.",
    date: "23 Nov",
    time: "10:00 PM",
    isFavorite: true,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/crystal_palace.png",
    awayTitle: "Crystal Palace",
    homeLogo: "assets/img/aston_villa.png",
    homeTitle: "Aston Villa",
    date: "24 Nov",
    time: "04:35 AM",
    isFavorite: true,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/wolves.png",
    awayTitle: "Wolves",
    homeLogo: "assets/img/fulham.png",
    homeTitle: "Fulham",
    date: "24 Nov",
    time: "02:35 AM",
    isFavorite: true,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/tottenham.png",
    awayTitle: "Tottenham Hotspur",
    homeLogo: "assets/img/man_city.png",
    homeTitle: "Manchester City",
    date: "24 Nov",
    time: "12:30 AM",
    isFavorite: true,
  ),
];
