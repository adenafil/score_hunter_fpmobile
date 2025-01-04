import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccer_live_score/dbHelper/ApiService.dart';

import '../dbHelper/sqlite_db.dart';

class UserController {
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    print(userCredential.user);



    final token = await user!.displayName ?? "";
    print("memek ${token}");


    ApiService apiService = ApiService();
    final response = await apiService.loginUser(creationTime: user!.metadata.creationTime.toString() , displayName: user!.displayName.toString(), email: user!.email.toString(), isAnonymous: user!.isAnonymous, isEmailVerified: user!.emailVerified, lastSignInTime: user!.metadata.lastSignInTime.toString(), phoneNumber: user!.phoneNumber.toString() ?? "", photoURL: user!.photoURL.toString(), token: token ?? "", username: user!.displayName.toString().splitMapJoin(" "));


    if (user != null) {
      // Mendapatkan token.
      print("memek ${token}");

      // Simpan token ke database lokal
      final dbHelper = DatabaseHelper();
        await dbHelper.saveToken(token);
    }

    print(await apiService.fetchHomeData());

    // POST KE API AUTHENTICATION SI GOLEK API
    return userCredential.user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
