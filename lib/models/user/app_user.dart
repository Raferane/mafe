import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String? displayName;
  final String city;
  final bool isAdmin;
  final DateTime createdAt;
  final bool isGoogle;

  AppUser({
    required this.city,
    required this.uid,
    required this.email,
    this.displayName,
    required this.isAdmin,
    required this.createdAt,
    required this.isGoogle,
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
      isGoogle: data?['isGoogle'] ?? false,
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
      'isGoogle': isGoogle,
    };
  }
}
