import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';

import '../dbHelper/sqlite_db.dart';

class UserController {
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<User?> loginWithGoogle() async {
    try {
      final googleAccount = await GoogleSignIn().signIn();
      if (googleAccount == null) return null;

      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // Update user setelah login berhasil
      user = userCredential.user;

      if (user == null) {
        throw Exception('Failed to get user data after login');
      }

      print(userCredential.user);

      // Gunakan null safety untuk menghindari null errors
      final displayName = user?.displayName ?? "Guest User";
      print("Token: $displayName");

      ApiService apiService = ApiService();
      final response = await apiService.loginUser(
          creationTime: user?.metadata.creationTime?.toString() ?? "",
          displayName: user?.displayName ?? "Guest User",
          email: user?.email ?? "",
          isAnonymous: user?.isAnonymous ?? false,
          isEmailVerified: user?.emailVerified ?? false,
          lastSignInTime: user?.metadata.lastSignInTime?.toString() ?? "",
          phoneNumber: "+6281234961804",
          photoURL: user?.photoURL ?? "",
          token: user?.displayName ?? "",
          username: (user?.displayName ?? "Guest User").splitMapJoin(" ")
      );

      // Simpan token ke database lokal
      if (user != null) {
        final dbHelper = DatabaseHelper();
        await dbHelper.saveToken(displayName);
      }

      print(await apiService.fetchHomeData());

      return user;

    } catch (e) {
      print('Error during Google Sign In: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      // Reset user setelah logout
      user = null;
    } catch (e) {
      print('Error during Sign Out: $e');
    }
  }
}