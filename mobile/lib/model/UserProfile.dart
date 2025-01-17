class UserProfile {
  final String username;
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final String creationTime;
  final String lastSignInTime;
  final String phoneNumber;
  final String photoURL;
  final String token;
  final Map<String, dynamic> statistic;

  UserProfile({
    required this.username,
    required this.displayName,
    required this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.creationTime,
    required this.lastSignInTime,
    required this.phoneNumber,
    required this.photoURL,
    required this.token,
    required this.statistic,
  });

  // Factory method untuk mengkonversi JSON (Map) ke objek UserProfile
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? '',
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      isAnonymous: json['isAnonymous'] ?? false,
      creationTime: json['creationTime'] ?? '',
      lastSignInTime: json['lastSignInTime'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      photoURL: json['photoURL'] ?? '',
      token: json['token'] ?? '',
      statistic: json['statistic'] ?? {},
    );
  }
}