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
    awayLogo: "assets/img/man_united.png",
    awayTitle: "Man United",
    homeLogo: "assets/img/liverpool.png",
    homeTitle: "Liverpool FC",
    date: "30 Dec",
    time: "06 : 30",
    isFavorite: true,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/swansea.png",
    awayTitle: "Tottenham",
    homeLogo: "assets/img/tottenham.png",
    homeTitle: "Swansea AFC",
    date: "30 Dec",
    time: "06 : 30",
    isFavorite: false,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/stoke.png",
    awayTitle: "Stoke City",
    homeLogo: "assets/img/arsenal.png",
    homeTitle: "Arsenal",
    date: "30 Dec",
    time: "06 : 30",
    isFavorite: false,
  ),
  UpcomingMatch(
    awayLogo: "assets/img/southampton.png",
    awayTitle: "Southhampton",
    homeLogo: "assets/img/sunderland.png",
    homeTitle: "Sunderland",
    date: "30 Dec",
    time: "06 : 30",
    isFavorite: false,
  ),
];
