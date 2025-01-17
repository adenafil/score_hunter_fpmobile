import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/widgets/match_goals_widget.dart';
import '../model/live_match_model.dart';
import 'dart:async';

class MatchDetailCard extends StatefulWidget {
  final LiveMatch liveMatch;
  const MatchDetailCard({super.key, required this.liveMatch});

  @override
  State<MatchDetailCard> createState() => _MatchDetailCardState();
}

class _MatchDetailCardState extends State<MatchDetailCard> {
  // State variables
  late Timer _timer;
  int _minutes = 44;
  int _seconds = 55;
  bool isFirstHalf = true;

  @override
  void initState() {
    super.initState();
    // Start match timer
    _startMatchTimer();
  }

  void _startMatchTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }

        // Handle half time and full time
        if (isFirstHalf && _minutes >= 45) {
          isFirstHalf = false;
          _minutes = 0;
          _seconds = 0;
        } else if (!isFirstHalf && _minutes >= 45) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liveMatch = widget.liveMatch;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: kAccentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stadium and Week Info
              Column(
                children: [
                  Text(
                    liveMatch.stadium,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Week ${liveMatch.stageWeek.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 10,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Teams and Score
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Home Team
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 64,
                              child: Image.network(liveMatch.homeLogo),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              liveMatch.homeTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Home',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Score and Time
                      Expanded(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: liveMatch.homeGoal.toString(),
                                    style: TextStyle(
                                      color: liveMatch.onTheWinner == 0
                                          ? kPrimaryColor
                                          : Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' : ${liveMatch.awayGoal}',
                                    style: TextStyle(
                                      color: liveMatch.onTheWinner == 1
                                          ? kPrimaryColor
                                          : Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              liveMatch.time,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 8,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Away Team
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 64,
                              child: Image.network(liveMatch.awayLogo),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              liveMatch.awayTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Away',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 16),

              // Match Goal Widget
              MatchGoalsWidget(liveMatch: liveMatch),

              const SizedBox(height: 16),

              // Betting Odds
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOddsPill('W1', liveMatch.votes["regularTime"]?["percentage"]["homeWin"].toString() ?? '0.0'),
                    const SizedBox(width: 16),
                    _buildOddsPill('X', liveMatch.votes["regularTime"]?["percentage"]["draw"].toString() ?? '0.0'),
                    const SizedBox(width: 16),
                    _buildOddsPill('W2', liveMatch.votes["regularTime"]?["percentage"]["awayWin"].toString() ?? '0.0'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOddsPill(String label, String odds) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: ShapeDecoration(
        color: kBackgroundColorDarken,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kSecondaryColor,
              fontSize: 10,
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            odds,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}