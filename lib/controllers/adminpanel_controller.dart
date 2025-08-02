import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/user/app_user.dart';

class AdminPanelController extends GetxController {
  final _isLoading = false.obs;
  final _isAdmin = false.obs;
  final _allUsers = <AppUser>[].obs;
  final _allEvents = <Event>[].obs;

  RxBool get isLoading => _isLoading;
  RxBool get isAdmin => _isAdmin;
  RxList<AppUser> get allUsers => _allUsers;
  RxList<Event> get allEvents => _allEvents;
  @override
  void onInit() {
    loadAllUsers();
    loadAllEvents();
    super.onInit();
  }

  Future<List<AppUser>> fetchAllUsers() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return querySnapshot.docs
        .map((doc) => AppUser.fromFirestore(doc, null))
        .toList();
  }

  Future<void> loadAllUsers() async {
    final users = await fetchAllUsers();
    allUsers.assignAll(users);
  }

  Future<void> banUser(String uid, bool ban) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isBanned': ban,
    });
    await loadAllUsers(); // Refresh the list
    Get.snackbar(
      'Success',
      ban ? 'User banned successfully' : 'User unbanned successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ban ? Colors.red[100] : Colors.green[100],
      colorText: ban ? Colors.red[900] : Colors.green[900],
      duration: Duration(seconds: 3),
    );
  }

  Future<void> createEvent(Event event) async {
    await FirebaseFirestore.instance
        .collection('events')
        .add(event.toFirestore());
    await loadAllEvents();
  }

  Future<List<Event>> fetchAllEvents() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    return querySnapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
  }

  Future<void> loadAllEvents() async {
    final events = await fetchAllEvents();
    _allEvents.assignAll(events);
  }

  Future<void> deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
    await loadAllEvents();
  }
}
