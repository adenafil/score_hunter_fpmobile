import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';
import '../constants.dart';
import '../model/up_coming_model.dart';

class UpcomingMatchDetailCard extends StatefulWidget {
  final UpcomingMatch upMatch;
  const UpcomingMatchDetailCard({super.key, required this.upMatch});

  @override
  State<UpcomingMatchDetailCard> createState() => _UpcomingMatchDetailCardState();
}

class _UpcomingMatchDetailCardState extends State<UpcomingMatchDetailCard> {
  // State untuk menyimpan nama stadion
  String _stadiumName = 'Loading...';
  late UpcomingMatchService _upcomingMatchService;

  @override
  void initState() {
    super.initState();
    _upcomingMatchService = UpcomingMatchService(); // Inisialisasi service
    _fetchStadiumName(); // Panggil method untuk fetch nama stadion
  }

  // Method untuk fetch nama stadion dari API
  void _fetchStadiumName() async {
    try {
      String stadiumName = await _upcomingMatchService.fetchStadiumName(widget.upMatch.matchId.toString());
      setState(() {
        _stadiumName = stadiumName; // Update state dengan nama stadion
      });
    } catch (e) {
      setState(() {
        _stadiumName = 'Failed to load stadium name'; // Handle error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    _stadiumName, // Gunakan _stadiumName dari state
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Week ${widget.upMatch.stageWeek.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Teams and VS
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
                              child: Image.network(
                                widget.upMatch.homeLogo,
                                height: 45,
                                width: 45,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.upMatch.homeTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
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

                      // VS and Match Date & Time
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'VS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                Text(
                                  widget.upMatch.date != null
                                      ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.upMatch.date!))
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.upMatch.time ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
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
                              child: Image.network(
                                widget.upMatch.awayLogo,
                                height: 45,
                                width: 45,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.upMatch.awayTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
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

              // Betting Odds
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOddsPill('W1', widget.upMatch.odds['homeWin'].toString()),
                    const SizedBox(width: 16),
                    _buildOddsPill('X', widget.upMatch.odds['draw'].toString()),
                    const SizedBox(width: 16),
                    _buildOddsPill('W2', widget.upMatch.odds['awayWin'].toString()),
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
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            odds,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}