import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unity_project/models/user/app_user.dart';

class AppService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<AppUser> user = Rxn<AppUser>();
  final _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  // fetch user
  Future<void> fetchUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      user.value = AppUser.fromFirestore(doc, null);
    }
  }

  // Restore The User Account
  Future<void> restoreUser() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        // First fetch the user data
        await fetchUser(currentUser.uid);
        // Then check for email verification and sync
      } else {
        user.value = null;
      }
    } catch (e) {
      // If there's an error, clear the user to prevent stale data
      user.value = null;
    }
  }

  // create user
  Future<void> createUser(AppUser appUser) async {
    await _db.collection('users').doc(appUser.uid).set(appUser.toFirestore());
    user.value = appUser;
  }

  Future<void> clearUser() async {
    user.value = null;
  }

  // sign out
  Future<void> signOut() async {
    _auth.signOut();
    GoogleSignIn().signOut();
    clearUser();
    Get.offAllNamed('/welcome');
  }

  // delete account
  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
    await _db.collection('users').doc(_auth.currentUser!.uid).delete();
    await clearUser();
    Get.offAllNamed('/welcome');
  }
}
