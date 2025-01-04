import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soccer_live_score/dbHelper/sqlite_db.dart';

class ApiService {
  final String baseUrl = 'https://api.scorehunter.my.id';
  final dbHelper = DatabaseHelper();


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
    final url = Uri.parse('$baseUrl/api/home');
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

}
