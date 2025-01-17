import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';
import 'package:soccer_live_score/model/live_match_model.dart';
import 'package:soccer_live_score/model/up_coming_model.dart';
import 'package:soccer_live_score/screens/match_detail.dart';
import 'package:soccer_live_score/screens/match_detail_screen.dart';
import 'package:soccer_live_score/screens/upmatch_detail.dart';
import 'package:soccer_live_score/widgets/live_match_detail_card.dart';
import '../widgets/live_match.dart';
import '../widgets/up_coming_match.dart';
import '../screens/match_detail.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  final UpcomingMatchService service = UpcomingMatchService();
  final LiveMatchService serviceLive = LiveMatchService();

  final List<Map<String, dynamic>> leagues = [
    {
      'image': 'assets/img/pl_white.png',
      'name': 'Premiere League',
    },
    {
      'image': 'assets/img/LaLiga.png',
      'name': 'La Liga',
    },
    {
      'image': 'assets/img/Bundesliga.png',
      'name': 'Bundesliga',
    },
    {
      'image': 'assets/img/Ligue1_Uber_Eats.png',
      'name': 'Ligue 1 Uber Eats',
    },
    {
      'image': 'assets/img/SerieA.png',
      'name': 'Serie A',
    },
  ];

  List<UpcomingMatch> upcomingMatches = [];
  List<LiveMatch> liveMatch = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<UpcomingMatch> matches = await service.fetchUpcomingMatches();
      List<LiveMatch> liveMatches = await serviceLive.fetchLiveMatches();
      setState(() {
        upcomingMatches = matches;
        liveMatch = liveMatches;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String selectedLeague = 'Premiere League';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : Column(
              children: [
                liveMatchText(),
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                      itemCount: liveMatch.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final live = liveMatch[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MatchDetail(liveMatch: live),
                              ),
                            );
                          },
                          child: LiveMatchData(live: live),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Text(
                        "Up-Coming Matches",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: kBackgroundColorDarken,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Colors.black12.withOpacity(0.08),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: upcomingMatches.length,
                      itemBuilder: (context, index) {
                        final upMatch = upcomingMatches[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpmatchDetail(upcomingMatch: upMatch),
                              ),
                            );
                          },
                          child: UpComingMatches(upMatch: upMatch),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Padding liveMatchText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            "End Matches",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: kPrimaryColor,
            ),
            onPressed: () {},
            child: const Text(
              "View all",
              style: TextStyle(
                color: kTransparentWhite,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize headerParts() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: kBackgroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/score_hunter_logo.png',
                    height: 32,
                  ),
                ),
                Positioned(
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur on the way maniez'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: kBackgroundColorDarken,
                      padding: const EdgeInsets.all(8),
                    ),
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 30,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(
                              '8',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}