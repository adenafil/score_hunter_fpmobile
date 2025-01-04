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
    final token = await dbHelper.getToken();
    print("ini token untuk delete account ${token}");
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-API-TOKKEN': token
        },
      );

      if (response.statusCode == 200) {
        // Mengembalikan hasil respons dalam bentuk Map
        print(response.body);
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

}
