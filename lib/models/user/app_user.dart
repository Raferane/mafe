import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String? displayName;
  final bool isAdmin;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    required this.isAdmin,
    required this.createdAt,
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
      isAdmin: data?['isAdmin'] ?? false,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      if (displayName != null) 'displayName': displayName,
      'isAdmin': isAdmin,
      'createdAt': createdAt,
    };
  }
}
