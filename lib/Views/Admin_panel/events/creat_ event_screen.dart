import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/adminpanel_controller.dart';
import 'package:unity_project/models/events/events_model.dart';

class CreateEventScreens extends StatefulWidget {
  const CreateEventScreens({super.key});

  @override
  State<CreateEventScreens> createState() => _CreateEventScreensState();
}

class _CreateEventScreensState extends State<CreateEventScreens> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _isLoading = false;

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
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
    if (date != null) {
      final time = await showTimePicker(
        context: context,
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
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _createEvent() async {
    if (!_formKey.currentState!.validate() || _selectedDateTime == null) {
      Get.snackbar(
        'Error',
        'Please fill all fields and select date/time',
        backgroundColor: Colors.grey[200],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    setState(() => _isLoading = true);
    final adminPanelController = Get.find<AdminPanelController>();
    final event = Event(
      id: '', // Firestore will generate the ID
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      location: _locationController.text.trim(),
      dateTime: _selectedDateTime!,
      createdBy: '', // Set this as needed
      participants: [],
      isActive: true,
    );
    await adminPanelController.createEvent(event);
    setState(() => _isLoading = false);
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    final grayBg = Color(0xfff5f6fa);
    final grayCard = Colors.grey[100];
    final grayBorder = Colors.grey[300];
    final grayText = Colors.grey[800];

    return Scaffold(
      backgroundColor: grayBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Event',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: grayText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    filled: true,
                    fillColor: grayCard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: grayBorder!),
                    ),
                  ),
                  validator:
                      (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Title required'
                              : null,
                ),
                const SizedBox(height: 20),
                // Description
                TextFormField(
                  controller: _descController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: grayCard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: grayBorder),
                    ),
                  ),
                  validator:
                      (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Description required'
                              : null,
                ),
                const SizedBox(height: 20),
                // Location
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    filled: true,
                    fillColor: grayCard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: grayBorder),
                    ),
                  ),
                  validator:
                      (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Location required'
                              : null,
                ),
                const SizedBox(height: 20),
                // Date & Time Picker
                GestureDetector(
                  onTap: _pickDateTime,
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date & Time',
                        filled: true,
                        fillColor: grayCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: grayBorder),
                        ),
                        suffixIcon: Icon(Icons.calendar_today, color: grayText),
                      ),
                      controller: TextEditingController(
                        text:
                            _selectedDateTime == null
                                ? ''
                                : '${_selectedDateTime!.toLocal()}'
                                    .split('.')[0]
                                    .replaceFirst(' ', '  '),
                      ),
                      validator:
                          (v) =>
                              _selectedDateTime == null
                                  ? 'Date & Time required'
                                  : null,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: grayBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: grayText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: grayText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        child:
                            _isLoading
                                ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  'Create Event',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
