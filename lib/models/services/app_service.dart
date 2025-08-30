import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unity_project/models/user/app_user.dart';
import 'package:unity_project/routes/app_routes.dart';

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
      Get.log('restoreUser');
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        Get.log('No current user found');
        user.value = null;
        return;
      }

      // Try to get a fresh token - this will fail if token is revoked
      try {
        await currentUser.getIdToken(true);
      } catch (tokenError) {
        Get.log('Token refresh failed (likely revoked): $tokenError');
        // Token is revoked, handle it
        await handleTokenRevoked();
        return;
      }

      // Token is valid, fetch user data
      await fetchUser(currentUser.uid);
      await _handleEmailVerification();
    } catch (e) {
      Get.log("Error in restoreUser: $e");
      // Check if it's a token-related error
      if (_isTokenRevokedError(e)) {
        await handleTokenRevoked();
      } else {
        user.value = null;
      }
    }
  }

  // Helper method to detect token revocation errors
  bool _isTokenRevokedError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('user-token-expired') ||
        errorString.contains('user-not-found') ||
        errorString.contains('invalid-credential') ||
        errorString.contains('user-disabled');
  }

  // Handle token revocation gracefully
  Future<void> handleTokenRevoked() async {
    Get.log('Handling token revocation');

    // Clear current user data
    user.value = null;

    // Sign out from Firebase
    await _auth.signOut();
    await GoogleSignIn().signOut();

    // Show user-friendly message
    Get.snackbar(
      'Session Expired',
      'Your session has expired. Please log in again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
      duration: Duration(seconds: 4),
    );

    // Redirect to welcome/login screen
    Get.offAllNamed(AppRoutes.welcome);
  }

  Future<void> _handleEmailVerification() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      // Check if user has a pending email verification
      if (user.value?.newTempEmail != null) {
        // Check if the auth email now matches the temp email (verification completed)
        if (currentUser.email == user.value?.newTempEmail) {
          // Update the user document to remove newTempEmail and update email
          await _db.collection('users').doc(currentUser.uid).update({
            'email': currentUser.email,
            'newTempEmail': FieldValue.delete(), // Remove the temp email field
          });

          // Refresh user data
          await fetchUser(currentUser.uid);
        }
      }
    } catch (e) {
      Get.log('Error handling email verification: $e');
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

  Future<void> checkEmailVerificationAndSync() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    await currentUser.reload(); // important to refresh email after verification
    final refreshedUser = _auth.currentUser;
    final doc = await _db.collection('users').doc(refreshedUser!.uid).get();
    final pending = doc.data()?['newTempEmail'] as String?;

    if (pending != null && pending == refreshedUser.email) {
      await _db.collection('users').doc(refreshedUser.uid).update({
        'email': pending,
        'newTempEmail': FieldValue.delete(),
      });
      await fetchUser(refreshedUser.uid);
    }
  }

  // Check if current user is a guest
  bool isGuestUser() {
    final currentUser = _auth.currentUser;
    return currentUser?.isAnonymous ?? true;
  }

  // sign out
  Future<void> signOut() async {
    _auth.signOut();
    GoogleSignIn().signOut();
    clearUser();
    Get.offAllNamed(AppRoutes.welcome);
  }

  // delete account
  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
    await _db.collection('users').doc(_auth.currentUser!.uid).delete();
    await clearUser();
    Get.offAllNamed(AppRoutes.welcome);
  }
}
