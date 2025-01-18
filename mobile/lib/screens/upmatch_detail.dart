import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';
import 'package:soccer_live_score/model/up_coming_model.dart';
import 'package:soccer_live_score/widgets/live_match_detail_card.dart';
import 'package:soccer_live_score/widgets/upcoming_match_detail_card.dart';

class UpmatchDetail extends StatefulWidget {
  final UpcomingMatch upcomingMatch;
  const UpmatchDetail({super.key, required this.upcomingMatch});

  @override
  State<UpmatchDetail> createState() => _UpmatchDetailState();
}

class _UpmatchDetailState extends State<UpmatchDetail> {
  late List<String> guestCategoryItems;
  final UpcomingMatchService service = UpcomingMatchService();
  final ApiService votesService = ApiService();
  int totalVotes = 0;
  bool isLoading = true;
  String leagueName = 'Loading...'; // Tambahkan state untuk menyimpan nama liga


  // Asynchronous method to fetch upcoming matches
  Future<void> fetchUpcomingMatches() async {
    try {
            int matchId = widget.upcomingMatch.matchId;
     totalVotes = await votesService.fetchTotalVotes(matchId);
           leagueName = await votesService.fetchLeagueName(matchId); // Ambil nama liga

      guestCategoryItems = widget.upcomingMatch.votes.values
          .map(
              (vote) => (vote['categoryName'] as String?) ?? 'Unknown Category')
          .toList();

      // Fetch upcoming matches from service
      List<UpcomingMatch> matches = await service.fetchUpcomingMatches();
      // Update the state with fetched matches
      if (mounted) {
              setState(() {
        upcomingMatches = matches;
                isLoading = false;

      });

      }
    } catch (e) {
            setState(() {
        isLoading = false;
      });
      print('Error fetching upcoming matches: $e');
    }
  }


@override
void dispose() {
  super.dispose();
}

  @override
  void initState() {
    super.initState();

    // Validasi apakah votes ada
    if (widget.upcomingMatch.votes != null) {
          super.initState();
    fetchUpcomingMatches(); // Fetch the upcoming matches when the screen is initialized
      guestCategoryItems = widget.upcomingMatch.votes.values
          .map(
              (vote) => (vote['categoryName'] as String?) ?? 'Unknown Category')
          .toList();
    } else {
      guestCategoryItems = [];
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
              UpcomingMatchDetailCard(
                upMatch: widget.upcomingMatch,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: guestCategoryItems.isEmpty
                          ? const Center(
                        child: Text(
                          'No categories available.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: guestCategoryItems.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                                selectedWinner = null;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 2,
                                bottom: 2,
                              ),
                              decoration: BoxDecoration(
                                color: current == index
                                    ? kPrimaryColor50
                                    : kAccentColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  guestCategoryItems[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Implement UI code to guess the team here...
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Who will win in ${guestCategoryItems[current]}?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
Expanded(
  child: Column(
    children: [
      Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: () async {
             int matchId = widget.upcomingMatch.matchId;  // Ambil matchId dari objek upcomingMatch
            String username = 'user123';  // Gantilah dengan username pengguna yang aktif
            int type = 1;
            String answer = "0";


            if (guestCategoryItems[current] == "Regular Time") type = 1;
            if (guestCategoryItems[current] == "1st Half Time") type = 2;
            if (guestCategoryItems[current] == "2nd Half Time") type = 3;
            if (guestCategoryItems[current] == "First to Happen") type = 4;

    // Memanggil method postGuessMatch
    String message = await service.postGuessMatch(
      type: type,
      answer: answer,
      matchId: matchId.toString(),
      username: username,
    );


            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("$message")),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              widget.upcomingMatch.homeLogo,
              height: 45,
              width: 45,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${widget.upcomingMatch.votes["regularTime"]?["percentage"]["homeWin"] ?? 0.0}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
),
Expanded(
  child: Column(
    children: [
      Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: () async {
             int matchId = widget.upcomingMatch.matchId;  // Ambil matchId dari objek upcomingMatch
            String username = 'user123';  // Gantilah dengan username pengguna yang aktif
            int type = 1;
            String answer = "x";


            if (guestCategoryItems[current] == "Regular Time") type = 1;
            if (guestCategoryItems[current] == "1st Half Time") type = 2;
            if (guestCategoryItems[current] == "2nd Half Time") type = 3;
            if (guestCategoryItems[current] == "First to Happen") type = 4;

    // Memanggil method postGuessMatch
    String message = await service.postGuessMatch(
      type: type,
      answer: answer,
      matchId: matchId.toString(),
      username: username,
    );


            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("$message")),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                "X",
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${widget.upcomingMatch.votes["regularTime"]?["percentage"]["draw"] ?? 0.0}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kTransparentWhite,
          fontSize: 14,
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
),
Expanded(
  child: Column(
    children: [
      Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(32),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: () async {
             int matchId = widget.upcomingMatch.matchId;  // Ambil matchId dari objek upcomingMatch
            String username = 'user123';  // Gantilah dengan username pengguna yang aktif
            int type = 1;
            String answer = "1";


            if (guestCategoryItems[current] == "Regular Time") type = 1;
            if (guestCategoryItems[current] == "1st Half Time") type = 2;
            if (guestCategoryItems[current] == "2nd Half Time") type = 3;
            if (guestCategoryItems[current] == "First to Happen") type = 4;

    // Memanggil method postGuessMatch
    String message = await service.postGuessMatch(
      type: type,
      answer: answer,
      matchId: matchId.toString(),
      username: username,
    );


            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("$message")),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              widget.upcomingMatch.awayLogo,
              height: 45,
              width: 45,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${(widget.upcomingMatch.votes["regularTime"]?["percentage"]["awayWin"] ?? 0.0)}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Total votes: ${totalVotes}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTransparentWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: Colors.white.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: ShapeDecoration(
                            color: kPrimaryColor.withOpacity(.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          width: 80,
                          child:
                          Image.asset('assets/img/score_hunter_logo.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                Center(
                child: Text(
                  leagueName, // Tampilkan nama liga di sini
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
