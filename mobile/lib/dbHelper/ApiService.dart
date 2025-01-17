import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:soccer_live_score/dbHelper/sqlite_db.dart';
import 'package:soccer_live_score/model/up_coming_model.dart';

class ApiService {
  final String baseUrl = 'https://api.scorehunter.my.id';
  final dbHelper = DatabaseHelper();
    static const String cacheKeyProfile = 'user_data_cache';


  /// Method untuk login user menggunakan endpoint `/auth/google`.
  Future<Map<String, dynamic>> loginUser({
    required String creationTime,
    required String displayName,
    required String email,
    required bool isAnonymous,
    required bool isEmailVerified,
    required String lastSignInTime,
    required String phoneNumber,
    required String photoURL,
    required String token,
    required String username,
  }) async {
    final url = Uri.parse('$baseUrl/auth/google');

    // Membuat body request
    final Map<String, dynamic> body = {
      'creationTime': creationTime,
      'displayName': displayName,
      'email': email,
      'isAnonymous': isAnonymous,
      'isEmailVerified': isEmailVerified,
      'lastSignInTime': lastSignInTime,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'token': token,
      'username': username,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Mengembalikan hasil respons dalam bentuk Map
        return jsonDecode(response.body);
      } else {
        // Menangani error jika status code bukan 200
        return {
          'success': false,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    } catch (e) {
      // Menangani error koneksi atau parsing
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  /// Method untuk logout user menggunakan endpoint `/auth/google`.
  Future<Map<String, dynamic>> logoutUser() async {
    final url = Uri.parse('$baseUrl/auth/google');
    print("url");
      final dbHelper = DatabaseHelper();
    final token = await dbHelper.getToken();
    print("kunci ${token}");
    print("ini token untuk delete account ${token}");
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-API-TOKEN': token
        },
      );

      print("hasil ${response.body}");


      if (response.statusCode == 200) {
        print("masuk sini");
        final dbHelper = DatabaseHelper();

        await dbHelper.deleteToken();

        // Mengembalikan hasil respons dalam bentuk Map
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print("Selingkuh ke sini dia mas");
        print(response.body);
        final dbHelper = DatabaseHelper();

        await dbHelper.deleteToken();

        // Menangani error jika status code bukan 200
        return {
          'success': false,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    } catch (e) {
      // Menangani error koneksi atau parsing
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }


  /// Method untuk fetch data dari endpoint `/api/home`.
  Future<Map<String, dynamic>> fetchHomeData() async {
    final url = Uri.parse('api.scorehunter.my.id/api/upcomingmatch');
    final token = await dbHelper.getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'X-API-TOKEN': token,
        },
      );

      if (response.statusCode == 200) {
        final rawData = jsonDecode(response.body);
        final leagues = rawData['data']['leagues'];

        // Transformasi data sesuai format yang diinginkan
        final transformedLeagues = leagues.map((league) {
          return {
            'id': league['id'],
            'name': league['name'],
            'countryCode': league['ccode'],
            'matches': league['matches'].map((match) {
              return {
                'id': match['id'],
                'homeTeam': {
                  'id': match['home']['id'],
                  'name': match['home']['name'],
                  'longName': match['home']['longName'],
                  'score': match['home']['score'],
                },
                'awayTeam': {
                  'id': match['away']['id'],
                  'name': match['away']['name'],
                  'longName': match['away']['longName'],
                  'score': match['away']['score'],
                },
                'time': match['time'],
                'status': {
                  'finished': match['status']['finished'],
                  'reason': match['status']['reason']['long'],
                  'score': match['status']['scoreStr'],
                },
              };
            }).toList(),
          };
        }).toList();

        return {
          'success': true,
          'leagues': transformedLeagues,
        };
      } else {
        return {
          'success': false,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }


  Future<Map<String, dynamic>> fetchUserData(String token) async {
    final cacheManager = DefaultCacheManager();

    // Cek apakah data sudah ada di cache
    final fileInfo = await cacheManager.getFileFromCache(cacheKeyProfile);

    if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
      // Jika data cache masih valid, baca dari cache
      final cachedData = await fileInfo.file.readAsString();
      return json.decode(cachedData);
    }

    // Jika tidak ada cache atau cache sudah kadaluarsa, fetch dari API
    final response = await http.get(
      Uri.parse("https://api.scorehunter.my.id/api/user"),
      headers: {'X-API-TOKEN': await dbHelper.getToken()},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);

      // Simpan data ke cache dengan durasi 1 hari
      await cacheManager.putFile(
        cacheKeyProfile,
        utf8.encode(json.encode(userData)),
        maxAge: const Duration(minutes: 1),
      );

      return userData;
    } else {
      throw Exception('Failed to load user data');
    }
  }

}

class UpcomingMatchService {
  final String baseUrl = "https://api.scorehunter.my.id/api/upcomingmatch";
      final dbHelper = DatabaseHelper();
        final DefaultCacheManager cacheManager = DefaultCacheManager();

  Future<List<UpcomingMatch>> fetchUpcomingMatches() async {
    final cacheKey = 'upcoming_matches_cache'; // Key untuk cache

    try {
      // Cek apakah data sudah ada di cache
      final file = await cacheManager.getFileFromCache(cacheKey);

      if (file != null && file.validTill.isAfter(DateTime.now())) {
        // Jika data di cache masih valid, gunakan data dari cache
        final cachedData = await file.file.readAsString();
        final data = jsonDecode(cachedData);
        final List<dynamic> matches = data['data']
            .expand((item) => item['upcomingMatches'] as List)
            .toList();
        return matches.map((json) => UpcomingMatch.fromJson(json)).toList();
      }

      // Jika cache tidak ada atau sudah expired, fetch data baru dari API
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'X-API-TOKEN': await dbHelper.getToken(),
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> matches = data['data']
            .expand((item) => item['upcomingMatches'] as List)
            .toList();

        // Simpan data ke cache dengan durasi 3 menit
        await cacheManager.putFile(
          cacheKey,
          utf8.encode(jsonEncode(data)),
          maxAge: Duration(minutes: 5), // Durasi cache 3 menit
        );

        return matches.map((json) => UpcomingMatch.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch upcoming matches. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching upcoming matches: $e');
    }
  }


Future<String> postGuessMatch({
  required int type,
  required String answer,
  required String matchId,
  required String username,
}) async {
  // URL endpoint API
  const String url = 'https://api.scorehunter.my.id/api/user/guess';
      final dbHelper = DatabaseHelper();

  // Headers untuk request
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-TOKEN': await dbHelper.getToken(),
  };

  // Body JSON data
  final body = {
    "type": type,
    "answer": answer,
    "matchId": matchId,
    "username": username,
  };

  try {
    // Melakukan POST request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);

    // Cek apakah ada key 'message' atau 'errors' di dalam response
    if (responseMap.containsKey('message')) {
      String message = responseMap['message'];
      print('Message: $message');
    }

    if (responseMap.containsKey('errors')) {
      String errors = responseMap['errors'];
      print('Errors: $errors');
    }


    // Mengecek status response
    if (response.statusCode == 200) {
      // Berhasil

      return responseMap.containsKey('message') ? responseMap['message'] : responseMap['errors'];
      // print('Success: ${response.body}');
    } else {
      // Gagal
      return responseMap.containsKey('message') ? responseMap['message'] : responseMap['errors'];
      print('Failed: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    return "Gagal melakukan proses tebakan, check signal anda.";
    // Menangani error
    print('Error: $e');
  }

  
}

  Future<Map<String, dynamic>?> getMatchData(String matchId) async {
    final cacheKey = 'match_data_$matchId'; // Key untuk cache (unik berdasarkan matchId)

    try {
      // Cek apakah data sudah ada di cache
      final file = await cacheManager.getFileFromCache(cacheKey);

      if (file != null && file.validTill.isAfter(DateTime.now())) {
        // Jika data di cache masih valid, gunakan data dari cache
        final cachedData = await file.file.readAsString();
        return jsonDecode(cachedData);
      }

      // Jika cache tidak ada atau sudah expired, fetch data baru dari API
      final url = Uri.parse('$baseUrl/match?matchId=$matchId');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-API-TOKEN': await dbHelper.getToken(),
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Simpan data ke cache dengan durasi 3 menit
        await cacheManager.putFile(
          cacheKey,
          utf8.encode(jsonEncode(data)),
          maxAge: Duration(minutes: 5), // Durasi cache 3 menit
        );

        return data;
      } else {
        // Jika gagal, log error atau handle sesuai kebutuhan
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      // Handle exception seperti koneksi internet terputus
      print("Exception: $e");
      return null;
    }
  }

Future<String> fetchStadiumName(String matchId) async {
  final String apiUrl = 'http://api.scorehunter.my.id/api/match/stadium?matchId=$matchId';
  const String apiKey = 'ade';
  final DefaultCacheManager cacheManager = DefaultCacheManager();
  final cacheKey = 'stadium_name_$matchId'; // Key untuk cache (unik berdasarkan matchId)

  try {
    // Cek apakah data sudah ada di cache
    final file = await cacheManager.getFileFromCache(cacheKey);

    if (file != null && file.validTill.isAfter(DateTime.now())) {
      // Jika data di cache masih valid, gunakan data dari cache
      final cachedData = await file.file.readAsString();
      final Map<String, dynamic> data = json.decode(cachedData);
      final String stadiumName = data['data']['name'];
      return stadiumName;
    }

    // Jika cache tidak ada atau sudah expired, fetch data baru dari API
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-API-TOKEN': apiKey,
      },
    );

    print("stadium ${response.body}");

    if (response.statusCode == 200) {
      // Parse JSON response
      final Map<String, dynamic> data = json.decode(response.body);
      final String stadiumName = data['data']['name'];

      // Simpan data ke cache dengan durasi 1 tahun
      await cacheManager.putFile(
        cacheKey,
        utf8.encode(jsonEncode(data)),
        maxAge: Duration(days: 365), // Durasi cache 1 tahun
      );

      return stadiumName;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}



}