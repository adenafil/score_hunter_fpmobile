import 'package:flutter/material.dart';
import 'package:soccer_live_score/constants.dart';
import '../model/live_match_model.dart';

class MatchGoalsWidget extends StatelessWidget {
  final LiveMatch liveMatch;

  const MatchGoalsWidget({
    super.key,
    required this.liveMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Home Team Goals
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (liveMatch.homeGoalScorers.isNotEmpty) ...[
                for (var scorer in liveMatch.homeGoalScorers) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        scorer.split('(')[0].trim(), // Get player name
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        scorer.split('(')[1].replaceAll(')', ''), // Get minute
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  if (scorer != liveMatch.homeGoalScorers.last)
                    const SizedBox(height: 4),
                ],
              ],
            ],
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF252A4A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sports_soccer,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Goal',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

        // Away Team Goals
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (liveMatch.awayGoalScorers.isNotEmpty) ...[
                for (var scorer in liveMatch.awayGoalScorers) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        scorer.split('(')[1].replaceAll(')', ''), // Get minute
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        scorer.split('(')[0].trim(), // Get player name
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (scorer != liveMatch.awayGoalScorers.last)
                    const SizedBox(height: 4),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
