import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soccer_live_score/dbHelper/sqlite_db.dart';
import 'dart:convert';
import '../constants.dart';

class InPlayTab extends StatefulWidget {
  const InPlayTab({super.key});

  @override
  State<InPlayTab> createState() => _InPlayTabState();
}

class _InPlayTabState extends State<InPlayTab> {
  List<Map<String, dynamic>> matches = [];
  bool _isLoading = true;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    const String apiUrl =
        'https://api.scorehunter.my.id/api/user/history?isHistory=false';
    Map<String, String> headers = {
      'X-API-TOKEN': await dbHelper.getToken(),
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        final List<Map<String, dynamic>> formattedData = data.map((match) {
          return {
            'teams': List<Map<String, dynamic>>.from(match['teams']),
            'matchStatus': (match['matchStatus'] == "90:00")
                ? "Belum Di Mulai"
                : match['matchStatus'],
            'odds': match['odds'].toString(),
            'statusLabel': match['statusLabel'],
            'guessCategory': match['guessCategory'],
            'answer': match['answer']
          };
        }).toList();

        setState(() {
          matches = formattedData;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : matches.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/empty_data.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "No guesses in play,\nmake more predictions and win!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Handle match card tap
                      },
                      child: MatchCard(
                          teams: match['teams'],
                          matchStatus: match['matchStatus'],
                          odds: match['odds'],
                          statusLabel: match['statusLabel'],
                          guessCategory: match['guessCategory'],
                          answer: match['answer']),
                    ),
                  );
                },
              );
  }
}

class MatchCard extends StatelessWidget {
  final List<Map<String, dynamic>> teams;
  final String matchStatus;
  final String odds;
  final String statusLabel;
  final String guessCategory;
  final String answer;

  const MatchCard(
      {super.key,
      required this.teams,
      required this.matchStatus,
      required this.odds,
      required this.statusLabel,
      required this.guessCategory,
      required this.answer});

  @override
  Widget build(BuildContext context) {
    final int maxScore = teams
        .map((team) => team['score'] as int)
        .reduce((a, b) => a > b ? a : b);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kAccentColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                matchStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: teams.map((team) {
                  final bool isWinner = team['score'] == maxScore;
                  return _buildTeamRow(
                    team['name'],
                    team['logo'],
                    team['score'],
                    isWinner,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        teams[answer == "0" ? 0 : 1]['logo'],
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Odds',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            odds,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: kBackgroundColorDarken,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      guessCategory,
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFD3C529),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              "CHECKING YOUR GUESS, STAY TUNED!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamRow(
      String teamName, String logoPath, int score, bool isWinner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              logoPath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              teamName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (isWinner && teams[0]['score'] == teams[1]['score'])
              const Icon(
                Icons.arrow_right,
                color: Colors.white, // Warna putih jika kondisi pertama benar
                size: 16,
              )
            else if (isWinner)
              const Icon(
                Icons.arrow_right,
                color:
                    kPrimaryColor, // Warna ungu jika hanya isWinner yang benar
                size: 16,
              ),
            const SizedBox(width: 6),
            Text(
              score.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
