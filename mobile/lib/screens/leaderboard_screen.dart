import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer_live_score/constants.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  // Mock data - replace with your API data model
  final List<Map<String, dynamic>> leaderboardData = [
    {"rank": 1, "name": "Alex Sampuri", "wins": 394, "avatar": "assets/avatar1.png"},
    {"rank": 2, "name": "Go Youn Jung", "wins": 345, "avatar": "assets/avatar2.png"},
    {"rank": 3, "name": "Sisep British", "wins": 320, "avatar": "assets/avatar3.png"},
    {"rank": 4, "name": "Michael Sumain", "wins": 300, "avatar": "assets/avatar4.png"},
    {"rank": 5, "name": "Mehul Kanzariya", "wins": 243, "avatar": "assets/avatar5.png"},
    {"rank": 6, "name": "Steven Sudarsono", "wins": 220, "avatar": "assets/avatar6.png"},
    {"rank": 7, "name": "Alexander Suwito", "wins": 190, "avatar": "assets/avatar7.png"},
    {"rank": 8, "name": "Smith Marto", "wins": 174, "avatar": "assets/avatar8.png"},
    {"rank": 9, "name": "IRIS", "wins": 170, "avatar": "assets/avatar9.png"},
    {"rank": 10, "name": "Go Goo Dols", "wins": 100, "avatar": "assets/avatar10.png"},
    {"rank": 11, "name": "Yung Kai", "wins": 99, "avatar": "assets/avatar11.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(context),
      body: Column(
        children: [
          // User Stats Card
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar and Name
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red[100],
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mehul Kanzariya",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "243",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Global Rank
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Global Rank",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "5",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 50),
                Expanded(
                  child: Text(
                    "Players",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    "Win",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                final item = leaderboardData[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kAccentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Rank
                      SizedBox(
                        width: 30,
                        child: Text(
                          "${item['rank']}",
                          style: TextStyle(
                            color: item['rank'] <= 3
                                ? Colors.amber
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Avatar
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[100],
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      // Name
                      Expanded(
                        child: Text(
                          item['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Wins
                      SizedBox(
                        width: 80,
                        child: Text(
                          "${item['wins']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize headerParts(BuildContext context) {
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
            child: const Center(
              child: Text(
                "Leaderboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}