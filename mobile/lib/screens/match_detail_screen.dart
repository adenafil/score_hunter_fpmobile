import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/model/live_match_model.dart';
import 'package:soccer_live_score/widgets/live_match_detail.dart';
import 'package:soccer_live_score/widgets/live_match_stats.dart';

class MatchDetailScreen extends StatefulWidget {
  final LiveMatch liveMatch;
  const MatchDetailScreen({super.key, required this.liveMatch});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  List<Map<String, dynamic>> tabs = [
    {
      "label": "Stats",
    },
    {
      "label": "H2H",
    },
    {
      "label": "Table",
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120),
              padding: const EdgeInsets.only(
                top: 180,
                right: 20,
                left: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      tabs.length,
                      (index) {
                        final tab = tabs[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? kPrimaryColor
                                  : kBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
                              tab["label"],
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Statistik pertandingan
                  LiveMatchStats(
                    homeStats: widget.liveMatch.shotOnTarget,
                    awayStats: widget.liveMatch.shotOnTarget * 3,
                    title: "Shots  On Target",
                    homeValue: widget.liveMatch.shotOnTarget,
                    awayValue:
                        widget.liveMatch.shotOnTarget,
                    isHomeWinner: false,
                  ),
                  LiveMatchStats(
                    homeStats: widget.liveMatch.homeGoal,
                    awayStats: widget.liveMatch.awayGoal,
                    title: "Goals",
                    homeValue: widget.liveMatch.homeGoal,
                    awayValue: widget.liveMatch.awayGoal,
                    isHomeWinner: true,
                  ),
                  LiveMatchStats(
                    homeStats: widget.liveMatch.possession,
                    awayStats: widget.liveMatch.possession,
                    title: "Possession",
                    homeValue:
                        widget.liveMatch.possession,
                    awayValue: widget.liveMatch.possession,
                    isHomeWinner: true,
                  ),
                  LiveMatchStats(
                    homeStats: widget.liveMatch.yellowCard,
                    awayStats: widget.liveMatch.yellowCard,
                    title: "Yellow Cards",
                    homeValue: widget.liveMatch.yellowCard,
                    awayValue: widget.liveMatch.yellowCard,
                    isHomeWinner: false,
                  ),
                  LiveMatchStats(
                    homeStats: widget.liveMatch.redCard,
                    awayStats: widget.liveMatch.redCard,
                    title: "Red Cards",
                    homeValue: widget.liveMatch.redCard,
                    awayValue: widget.liveMatch.redCard,
                    isHomeWinner: false,
                  ),
                  LiveMatchStats(
                    homeStats: widget.liveMatch.corner,
                    awayStats: widget.liveMatch.corner,
                    title: "Corner Kicks",
                    homeValue: widget.liveMatch.redCard,
                    awayValue: widget.liveMatch.redCard,
                    isHomeWinner: true,
                  ),
                ],
              ),
            ),
            LiveMatchDetail(widget: widget),
          ],
        ),
      ),
    );
  }

  AppBar headerParts(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, Colors.amber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(IconsaxPlusLinear.arrow_square_left),
              ),
            ),
          ),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Champions League",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
                color: Colors.white,
              ),
            ),
            Text(
              "GROUP STAGE",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                letterSpacing: -1,
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                IconsaxPlusLinear.more_square,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
