import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/user/app_user.dart';

class AdminPanelController extends GetxController {
  // Reactive state
  final _isLoading = false.obs;
  final _isAdmin = false.obs;
  final _allUsers = <AppUser>[].obs;
  final _allEvents = <Event>[].obs;

  // Create/Edit form state
  final _selectedDateTime = Rxn<DateTime>();
  final _isSaving = false.obs;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _organizationController = TextEditingController();

  // Getters
  RxBool get isLoading => _isLoading;
  RxBool get isAdmin => _isAdmin;
  RxList<AppUser> get allUsers => _allUsers;
  RxList<Event> get allEvents => _allEvents;
  Rxn<DateTime> get selectedDateTime => _selectedDateTime;
  RxBool get isSaving => _isSaving;
  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;
  TextEditingController get locationController => _locationController;
  TextEditingController get organizationController => _organizationController;

  get tabController => null;

  @override
  void onInit() {
    loadAllUsers();
    loadAllEvents();
    super.onInit();
  }

  @override
  void onClose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _organizationController.dispose();
    super.onClose();
  }

  // Users
  Future<List<AppUser>> fetchAllUsers() async {
    final query = await FirebaseFirestore.instance.collection('users').get();
    return query.docs.map((d) => AppUser.fromFirestore(d, null)).toList();
  }

  Future<void> loadAllUsers() async {
    final users = await fetchAllUsers();
    _allUsers.assignAll(users);
  }

  Future<void> banUser(String uid, bool ban) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isBanned': ban,
    });
    await loadAllUsers();
    Get.snackbar(
      'Success',
      ban ? 'User banned successfully' : 'User unbanned successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ban ? Colors.red[100] : Colors.green[100],
      colorText: ban ? Colors.red[900] : Colors.green[900],
      duration: const Duration(seconds: 3),
    );
  }

  // Events CRUD
  Future<List<Event>> fetchAllEvents() async {
    final query = await FirebaseFirestore.instance.collection('events').get();
    return query.docs.map((d) => Event.fromFirestore(d)).toList();
  }

  Future<void> loadAllEvents() async {
    final events = await fetchAllEvents();
    _allEvents.assignAll(events);
  }

  Future<void> createEvent(Event event) async {
    await FirebaseFirestore.instance
        .collection('events')
        .add(event.toFirestore());
    await loadAllEvents();
    Get.back();
  }

  Future<void> updateEvent(Event updatedEvent) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(updatedEvent.id)
        .update({
          'title': updatedEvent.title,
          'description': updatedEvent.description,
          'location': updatedEvent.location,
          'dateTime': Timestamp.fromDate(updatedEvent.dateTime),
          'updatedAt': Timestamp.now(),
          'organization': updatedEvent.organization,
        });
    await loadAllEvents();
    Get.back();
  }

  Future<void> deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
    await loadAllEvents();
  }

  // Create/Edit screen helpers
  void initializeFormForEdit(Event? event) {
    if (event != null) {
      _titleController.text = event.title;
      _descController.text = event.description;
      _locationController.text = event.location;
      _selectedDateTime.value = event.dateTime;
      _organizationController.text = event.organization;
    } else {
      resetForm();
    }
  }

  void resetForm() {
    _titleController.clear();
    _descController.clear();
    _locationController.clear();
    _selectedDateTime.value = null;
    _organizationController.clear();
  }

  bool validateForm() {
    if (_titleController.text.trim().isEmpty) {
      _toastError('Title is required');
      return false;
    }
    if (_descController.text.trim().isEmpty) {
      _toastError('Description is required');
      return false;
    }
    if (_locationController.text.trim().isEmpty) {
      _toastError('Location is required');
      return false;
    }
    if (_selectedDateTime.value == null) {
      _toastError('Please select date and time');
      return false;
    }
    if (_organizationController.text.trim().isEmpty) {
      _toastError('Organization is required');
      return false;
    }
    return true;
  }

  Future<void> saveEvent(Event? eventToEdit) async {
    if (!validateForm()) return;
    _isSaving.value = true;
    try {
      if (eventToEdit != null) {
        final updated = Event(
          id: eventToEdit.id,
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          location: _locationController.text.trim(),
          dateTime: _selectedDateTime.value!,
          createdBy: eventToEdit.createdBy,
          participants: eventToEdit.participants,
          isActive: eventToEdit.isActive,
          organization: _organizationController.text.trim(),
        );
        await updateEvent(updated);
      } else {
        final created = Event(
          id: '',
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          location: _locationController.text.trim(),
          dateTime: _selectedDateTime.value!,
          createdBy: 'Admin',
          participants: [],
          isActive: true,
          organization: _organizationController.text.trim(),
        );
        await createEvent(created);
      }
      Get.snackbar(
        'Success',
        eventToEdit != null
            ? 'Event updated successfully!'
            : 'Event created successfully!',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      resetForm();
      Get.back(result: true);
    } catch (e) {
      _toastError('Failed to save event: $e');
    } finally {
      _isSaving.value = false;
    }
  }

  Future<void> pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      builder:
          (context, child) => Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.grey[800]!,
                onPrimary: Colors.white,
                surface: Colors.grey[200]!,
                onSurface: Colors.grey[900]!,
              ),
            ),
            child: child!,
          ),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder:
          (context, child) => Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.grey[800]!,
                onPrimary: Colors.white,
                surface: Colors.grey[200]!,
                onSurface: Colors.grey[900]!,
              ),
            ),
            child: child!,
          ),
    );
    if (time == null) return;
    _selectedDateTime.value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  // Navigation from Events tab
  void editEvent(Event event) {
    Get.toNamed('/createEventScreen', arguments: event);
  }

  Future<void> createNewEvent() async {
    final result = await Get.toNamed('/createEventScreen');
    if (result == true) await loadAllEvents();
  }

  void showDeleteDialog(Event event) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xffedf2f4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFEF4444),
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Delete Event',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete ${event.title}? This action cannot be undone.',
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[800]!,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              deleteEvent(event.id);
              Get.back();
            },

            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toastError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
