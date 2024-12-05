import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  // Dummy data untuk testing
  final List<Map<String, dynamic>> matches = [
    {
      'teams': [
        {
          'name': 'Aston Villa',
          'logo': 'assets/img/aston_villa.png',
          'score': 0,
        },
        {
          'name': 'FC Bayern München',
          'logo': 'assets/img/bayern.png',
          'score': 5,
        },
      ],
      'matchStatus': '1st half, time elapse: 44:55',
      'odds': '1.53',
      'statusLabel': 'WIN',
      'guessCategory': 'Regular Time',
      'date': DateTime(2024, 11, 7),
    },
    {
      'teams': [
        {
          'name': 'Chelsea F.C',
          'logo': 'assets/img/chelsea.png',
          'score': 2,
        },
        {
          'name': 'Leicester City',
          'logo': 'assets/img/leicester_city.png',
          'score': 0,
        },
      ],
      'matchStatus': '1st half, time elapse: 44:55',
      'odds': '3.73',
      'statusLabel': 'WIN',
      'guessCategory': 'Regular Time',
      'date': DateTime(2024, 12, 5),
    },
    {
      'teams': [
        {
          'name': 'Liverpool F.C.',
          'logo': 'assets/img/liverpool.png',
          'score': 3,
        },
        {
          'name': 'Manchester United',
          'logo': 'assets/img/man_united.png',
          'score': 0,
        },
      ],
      'matchStatus': '1st half, time elapse: 40:12',
      'odds': '3.75',
      'statusLabel': 'LOSE',
      'guessCategory': 'First to Happen',
      'date': DateTime(2024, 12, 2),
    },
    {
      'teams': [
        {
          'name': 'AFC Bournemouth',
          'logo': 'assets/img/afc_bournemouth.png',
          'score': 2,
        },
        {
          'name': 'Nottingham Forest',
          'logo': 'assets/img/nottingham_forest.png',
          'score': 1,
        },
      ],
      'matchStatus': '1st half, time elapse: 44:55',
      'odds': '2.56',
      'statusLabel': 'WIN',
      'guessCategory': 'Regular Time',
      'date': DateTime(2024, 12, 3),
    },
  ];

  DateTime? _startDate;
  DateTime? _endDate;
  List<Map<String, dynamic>> _filteredMatches = [];

  @override
  void initState() {
    super.initState();
    // Set default filter ke 30 hari terakhir saat pertama kali di load
    _startDate = DateTime.now().subtract(const Duration(days: 30));
    _endDate = DateTime.now();
    _filterMatchesByDatePeriod();
  }

  void _filterMatchesByDatePeriod() {
    setState(() {
      _filteredMatches = matches.where((match) {
        DateTime matchDate = match['date'];
        return matchDate.isAfter(_startDate!) &&
            matchDate.isBefore(_endDate!.add(const Duration(days: 1)));
      }).toList();
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    // Tentukan batas tanggal terakhir yang dapat dipilih (60 hari dari hari ini)
    final DateTime sixtyDaysAgo =
        DateTime.now().subtract(const Duration(days: 60));
    final DateTime today = DateTime.now();

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: sixtyDaysAgo, // Hanya bisa memilih dari 60 hari yang lalu
      lastDate: today, // Hingga hari ini
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      helpText: 'Maximum selected period: 30 days',
      saveText: 'Apply',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: kAccentColor,
              surface: kBackgroundColorDarken,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Validasi periode maksimum 30 hari
      if (picked.end.difference(picked.start).inDays > 30) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum period is 30 days🤗'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _filterMatchesByDatePeriod();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kAccentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => _selectDateRange(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text(
                    _startDate != null && _endDate != null
                        ? '${DateFormat('dd MMM yyyy').format(_startDate!)} - ${DateFormat('dd MMM yyyy').format(_endDate!)}'
                        : 'Choose period!',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredMatches.isEmpty
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
                        "No history available,\nmake more predictions and win!",
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredMatches.length,
                  itemBuilder: (context, index) {
                    final match = _filteredMatches[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MatchCard(
                        teams: match['teams'],
                        matchStatus: match['matchStatus'],
                        odds: match['odds'],
                        statusLabel: match['statusLabel'],
                        guessCategory: match['guessCategory'],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final List<Map<String, dynamic>> teams;
  final String matchStatus;
  final String odds;
  final String statusLabel;
  final String guessCategory;

  const MatchCard({
    super.key,
    required this.teams,
    required this.matchStatus,
    required this.odds,
    required this.statusLabel,
    required this.guessCategory,
  });

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
                      Image.asset(
                        teams[1]['logo'],
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
              color:
                  statusLabel == 'WIN' ? Color(0xFF2DC473) : Color(0xFFE54640),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              statusLabel,
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
            Image.asset(
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
            if (isWinner)
              const Icon(
                Icons.arrow_right,
                color: Colors.white,
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
