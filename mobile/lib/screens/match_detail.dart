import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/model/live_match_model.dart';
import 'package:soccer_live_score/widgets/live_match_detail_card.dart';
import 'package:intl/intl.dart';

class MatchDetail extends StatefulWidget {
  final LiveMatch liveMatch;
  const MatchDetail({super.key, required this.liveMatch});

  @override
  State<MatchDetail> createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  final LiveMatchService serviceLive = LiveMatchService();

  List<LiveMatch> liveMatch = [];

  late List<String> guestCategoryItems;

  @override
  void initState() {
    super.initState();
    fetchLiveMatch();

    // Validasi apakah votes ada
    if (widget.liveMatch.votes != null) {
      guestCategoryItems = widget.liveMatch.votes.values
          .map(
              (vote) => (vote['categoryName'] as String?) ?? 'Unknown Category')
          .toList();
    } else {
      guestCategoryItems = [];
    }
  }

  Future<void> fetchLiveMatch() async {
    try {
      // Fetch upcoming matches from service
      List<LiveMatch> matches = await serviceLive.fetchLiveMatches();
      // Update the state with fetched matches
      setState(() {
        liveMatch = matches;
      });
    } catch (e) {
      print('Error fetching upcoming matches: $e');
    }
  }

  int current = 0;
  String? selectedWinner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorDarken,
      appBar: headerParts(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MatchDetailCard(
              liveMatch: widget.liveMatch,
            ),
            // Match Detail Guess Component
            // Column(
            //   children: [
            //     SizedBox(
            //       height: 60,
            //       width: double.infinity,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: guestCategoryItems.isEmpty
            //             ? const Center(
            //                 child: Text(
            //                   'No categories available.',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               )
            //             : ListView.builder(
            //                 physics: const BouncingScrollPhysics(),
            //                 itemCount: guestCategoryItems.length,
            //                 scrollDirection: Axis.horizontal,
            //                 itemBuilder: (context, index) {
            //                   return GestureDetector(
            //                     onTap: () {
            //                       setState(() {
            //                         current = index;
            //                         selectedWinner = null;
            //                       });
            //                     },
            //                     child: AnimatedContainer(
            //                       duration: const Duration(milliseconds: 300),
            //                       margin: const EdgeInsets.symmetric(
            //                         horizontal: 10,
            //                       ),
            //                       padding: const EdgeInsets.only(
            //                         left: 16,
            //                         right: 16,
            //                         top: 2,
            //                         bottom: 2,
            //                       ),
            //                       decoration: BoxDecoration(
            //                         color: current == index
            //                             ? kPrimaryColor50
            //                             : kAccentColor,
            //                         borderRadius: BorderRadius.circular(50),
            //                       ),
            //                       child: Center(
            //                         child: Text(
            //                           guestCategoryItems[index],
            //                           style: const TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 12,
            //                             fontFamily: 'PlusJakartaSans',
            //                             fontWeight: FontWeight.w500,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //       ),
            //     ),
            //
            //     // Implement UI code to guess the team here...
            //     Padding(
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 16.0, vertical: 24.0),
            //       child: Container(
            //         width: double.infinity,
            //         clipBehavior: Clip.antiAlias,
            //         decoration: ShapeDecoration(
            //           color: kAccentColor,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(24),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(20.0),
            //           child: Column(
            //             children: [
            //               Text(
            //                 "Who will win in ${guestCategoryItems[current]}?",
            //                 textAlign: TextAlign.center,
            //                 style: const TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18,
            //                   fontFamily: 'PlusJakartaSans',
            //                   fontWeight: FontWeight.w700,
            //                 ),
            //               ),
            //               const SizedBox(height: 16),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   Expanded(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           height: 64,
            //                           width: 64,
            //                           decoration: BoxDecoration(
            //                             border: Border.all(
            //                               color: Colors.white.withOpacity(0.5),
            //                               width: 1,
            //                             ),
            //                             borderRadius: BorderRadius.circular(32),
            //                             color: Colors.transparent,
            //                           ),
            //                           child: AbsorbPointer(
            //                             child: InkWell(
            //                               onTap: null,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Image.asset(
            //                                   widget.liveMatch.homeLogo,
            //                                   fit: BoxFit.contain,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(height: 8),
            //                         Text(
            //                           '${(widget.liveMatch.votes["regularTime"]?["percentage"]["homeTeam"] ?? 0.0).toStringAsFixed(1)}%',
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 14,
            //                             fontFamily: 'PlusJakartaSans',
            //                             fontWeight: FontWeight.w700,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   Expanded(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           height: 64,
            //                           width: 64,
            //                           decoration: BoxDecoration(
            //                             border: Border.all(
            //                               color: Colors.white.withOpacity(0.5),
            //                               width: 1,
            //                             ),
            //                             borderRadius: BorderRadius.circular(32),
            //                             color: Colors.transparent,
            //                           ),
            //                           child: const AbsorbPointer(
            //                             child: InkWell(
            //                               onTap: null,
            //                               child: Padding(
            //                                   padding: EdgeInsets.all(8.0),
            //                                   child: Center(
            //                                     child: Text(
            //                                       "X",
            //                                       style: TextStyle(
            //                                         fontFamily:
            //                                             'PlusJakartaSans',
            //                                         fontSize: 24,
            //                                         fontWeight: FontWeight.bold,
            //                                         color: Colors.white,
            //                                       ),
            //                                     ),
            //                                   )),
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(height: 8),
            //                         Text(
            //                           '${(widget.liveMatch.votes["regularTime"]?["percentage"]["draw"] ?? 0.0).toStringAsFixed(1)}%',
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                             color: kTransparentWhite,
            //                             fontSize: 14,
            //                             fontFamily: 'PlusJakartaSans',
            //                             fontWeight: FontWeight.w700,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   Expanded(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           height: 64,
            //                           width: 64,
            //                           decoration: BoxDecoration(
            //                             border: Border.all(
            //                               color: kPrimaryColor,
            //                               width: 2,
            //                             ),
            //                             borderRadius: BorderRadius.circular(32),
            //                             color: Colors.transparent,
            //                           ),
            //                           child: AbsorbPointer(
            //                             child: InkWell(
            //                               onTap: null,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Image.asset(
            //                                   widget.liveMatch.awayLogo,
            //                                   fit: BoxFit.contain,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(height: 8),
            //                         Text(
            //                           '${(widget.liveMatch.votes["regularTime"]?["percentage"]["awayTeam"] ?? 0.0).toStringAsFixed(1)}%',
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 14,
            //                             fontFamily: 'PlusJakartaSans',
            //                             fontWeight: FontWeight.w700,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20),
            //                 child: Text(
            //                   'Total votes: ${NumberFormat("#,##0").format(widget.liveMatch.votes["regularTime"]?["totalVotes"] ?? 0)}',
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color: kTransparentWhite,
            //                     fontSize: 16,
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(height: 16),
            //               Divider(color: Colors.white.withOpacity(0.5)),
            //               const SizedBox(height: 16),
            //               Container(
            //                 padding: const EdgeInsets.symmetric(
            //                     horizontal: 12, vertical: 8),
            //                 decoration: ShapeDecoration(
            //                   color: kPrimaryColor.withOpacity(.25),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(4),
            //                   ),
            //                 ),
            //                 width: 80,
            //                 child:
            //                     Image.asset('assets/img/score_hunter_logo.png'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kBackgroundColorDarken,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                // Logo di tengah
                const Center(
                  child: Text(
                    "Belanda", // Up Header
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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