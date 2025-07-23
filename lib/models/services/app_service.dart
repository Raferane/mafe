import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/user/app_user.dart';

class AppService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<AppUser> user = Rxn<AppUser>();

  // fetch user
  Future<void> fetchUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      user.value = AppUser.fromFirestore(doc, null);
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
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
    await fetchUser(uid);
  }
}
