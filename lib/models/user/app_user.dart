import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String? displayName;
  final String city;
  final bool isAdmin;
  final DateTime createdAt;
  final bool isBanned;
  final bool isGoogle;
  final String? newTempEmail;

  AppUser({
    required this.city,
    required this.uid,
    required this.email,
    this.displayName,
    required this.isAdmin,
    required this.createdAt,
    required this.isBanned,
    required this.isGoogle,
    this.newTempEmail,
  });

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      uid: data?['uid'],
      email: data?['email'],
      displayName: data?['displayName'],
      city: data?['city'],
      isAdmin: data?['isAdmin'] ?? false,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      isBanned: data?['isBanned'] ?? false,
      isGoogle: data?['isGoogle'] ?? false,
      newTempEmail: data?['newTempEmail'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      if (displayName != null) 'displayName': displayName,
      'city': city,
      'isAdmin': isAdmin,
      'createdAt': createdAt,
      'isBanned': isBanned,
      'isGoogle': isGoogle,
      if (newTempEmail != null) 'newTempEmail': newTempEmail,
    };
  }
}
