import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soccer_live_score/model/live_match_model.dart';
import 'package:soccer_live_score/model/up_coming_model.dart';
import 'package:soccer_live_score/screens/match_detail_screen.dart';
import '../widgets/live_match.dart';
import '../widgets/up_coming_match.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  final List<Map<String, dynamic>> leagues = [
    {
      'image': 'assets/pl.png',
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

  String selectedLeague = 'Premiere League';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerParts(),
      body: Column(
        children: [
          liveMatchText(),
          SizedBox(
            height: 230,
            child: ListView.builder(
                itemCount: liveMatches.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final live = liveMatches[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MatchDetailScreen(liveMatch: live),
                        ),
                      );
                    },
                    child: LiveMatchData(live: live),
                  );
                }),
          ),
          // for up-coming match
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "Up-Coming Matches",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -1.5,
                    color: Colors.black54,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black12.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedLeague,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 16,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedLeague = value!;
                      });
                    },
                    items: leagues.map<DropdownMenuItem<String>>(
                        (Map<String, dynamic> league) {
                      return DropdownMenuItem<String>(
                        value: league['name'],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              league['image'],
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              league['name'],
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: upcomingMatches.length,
              itemBuilder: (context, index) {
                final upMatch = upcomingMatches[index];
                return UpComingMatches(upMatch: upMatch);
              },
            ),
          )),
        ],
      ),
    );
  }

  Padding liveMatchText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            "Live Match",
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Colors.black54,
              letterSpacing: -1.5,
            ),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: kPrimaryColor,
            ),
            onPressed: () {},
            child: Text(
              "See all",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
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
            height: 72, // Tinggi AppBar
            decoration: BoxDecoration(
              color: kBackgroundColor, // Warna latar belakang AppBar
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center, // Pusatkan elemen di tengah vertikal
              children: [
                // Logo di tengah
                Center(
                  child: Image.asset(
                    'assets/img/score_hunter_logo.png',
                    height: 32,
                  ),
                ),
                // Tombol notifikasi di kanan
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
