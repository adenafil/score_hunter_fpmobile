import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:soccer_live_score/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';
import 'package:soccer_live_score/model/live_match_model.dart';
import 'package:soccer_live_score/model/up_coming_model.dart';
import 'package:soccer_live_score/screens/match_detail.dart';
import 'package:soccer_live_score/screens/match_detail_screen.dart';
import 'package:soccer_live_score/screens/upmatch_detail.dart';
import 'package:soccer_live_score/widgets/live_match_detail_card.dart';
import '../widgets/live_match.dart';
import '../widgets/up_coming_match.dart';
import '../screens/match_detail.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  final UpcomingMatchService service = UpcomingMatchService();
  final LiveMatchService serviceLive = LiveMatchService();


  List<UpcomingMatch> upcomingMatches = [];
  List<LiveMatch> liveMatch = [];
  bool isLoading = true;
  bool isLoadMore = false; // Untuk menandai apakah sedang memuat data tambahan
  int currentPage = 1; // Halaman saat ini
  final int limit = 10; // Jumlah data per halaman
  final ScrollController _scrollController = ScrollController(); // Controller untuk scroll


  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(_onScroll); // Tambahkan listener untuk scroll
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Hapus listener saat widget di-dispose
    _scrollController.dispose();
    super.dispose();
  }

  // Method untuk mendeteksi scroll
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadMoreData(); // Muat data tambahan saat mencapai akhir list
    }
  }


  Future<void> fetchData() async {
    try {
      List<UpcomingMatch> matches = await service.fetchUpcomingMatches();
      List<LiveMatch> liveMatches = await serviceLive.fetchLiveMatches();
      if (mounted) {
              setState(() {
        upcomingMatches = matches;
        liveMatch = liveMatches;
        isLoading = false;
      });

      }
    } catch (e) {
      print('Error fetching data: $e');
    // Handle errors and ensure the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    }
  }


  Future<void> loadMoreData() async {
    if (isLoadMore) return; // Hindari multiple calls

    setState(() {
      isLoadMore = true;
    });

    try {
      currentPage++; // Pindah ke halaman berikutnya
      List<LiveMatch> newMatches = await serviceLive.fetchLiveMatches(page: currentPage, limit: limit);

      if (mounted) {
        setState(() {
          liveMatch.addAll(newMatches); // Tambahkan data baru ke list yang ada
          isLoadMore = false;
        });
      }
    } catch (e) {
      print('Error loading more data: $e');
      if (mounted) {
        setState(() {
          isLoadMore = false;
        });
      }
    }
  }


  String selectedLeague = 'Premiere League';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchData, // Fungsi yang dipanggil saat refresh
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    liveMatchText(),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
  controller: _scrollController, // Tambahkan ScrollController
  itemCount: liveMatch.length + (isLoadMore ? 1 : 0), // Tambahkan 1 item untuk loading indicator
  shrinkWrap: true,
  padding: const EdgeInsets.only(left: 20),
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) {
    if (index == liveMatch.length) {
      // Tampilkan loading indicator di akhir list
      return Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    }

    final live = liveMatch[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MatchDetail(liveMatch: live),
          ),
        );
      },
      child: LiveMatchData(live: live),
    );
  },
),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Text(
                            "Up-Coming Matches",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
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
                              color: kBackgroundColorDarken,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black12.withOpacity(0.08),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: upcomingMatches.length,
                        itemBuilder: (context, index) {
                          final upMatch = upcomingMatches[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpmatchDetail(upcomingMatch: upMatch),
                                ),
                              );
                            },
                            child: UpComingMatches(upMatch: upMatch),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Padding liveMatchText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            "End Matches And Live Matches",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const Spacer(),
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
                Center(
                  child: Image.asset(
                    'assets/img/score_hunter_logo.png',
                    height: 32,
                  ),
                ),
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