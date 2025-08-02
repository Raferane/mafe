import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/user/app_user.dart';

class AppService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<AppUser> user = Rxn<AppUser>();

  // fetch user
  Future<void> fetchUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      user.value = AppUser.fromFirestore(doc, null);
    }
  }

  // Restore The User Account
  Future<void> restoreUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      await fetchUser(currentUser.uid);
    } else {
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

  // update user
  Future<void> editUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
    await fetchUser(uid);
  }

  // Edit Email
  Future<void> editEmail(String email) async {
    try {
      //updating email in firebase auth
      await _auth.currentUser?.verifyBeforeUpdateEmail(email);

      //updating the email in the database
      await editUser(_auth.currentUser!.uid, {'email': email});

      //re-fetching the user
      await fetchUser(_auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Email not valid';
          break;
        case 'email-already-in-use':
          message = 'Email already in use';
          break;
        case 'requires-recent-login':
          message = 'Please login again to change email';
          break;
        default:
          message = 'An error occurred';
      }
      throw message;
    }
  }

  // Edit Password
  Future<void> editPassword(String uid, String password) async {
    await _auth.currentUser?.updatePassword(password);
    await editUser(uid, {'password': password});
  }

  // read events
  Future<List<Event>> readEvents() async {
    final events = await _db.collection('events').get();
    return events.docs.map((doc) => Event.fromFirestore(doc)).toList();
  }
}
