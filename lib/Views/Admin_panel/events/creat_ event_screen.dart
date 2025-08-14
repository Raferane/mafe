import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/adminpanel_controller.dart';
import 'package:unity_project/models/events/events_model.dart';

class CreateEventScreens extends StatefulWidget {
  final Event? eventToEdit; // null for create, Event for edit
  const CreateEventScreens({super.key, this.eventToEdit});

  @override
  State<CreateEventScreens> createState() => _CreateEventScreensState();
}

class _CreateEventScreensState extends State<CreateEventScreens> {
  final _formKey = GlobalKey<FormState>();
  final adminPanelController = Get.find<AdminPanelController>();

  @override
  void initState() {
    super.initState();
    // Initialize form with event data if editing
    adminPanelController.initializeFormForEdit(widget.eventToEdit);
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
                  widget.eventToEdit != null ? 'Edit Event' : 'Create Event',
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
                  controller: adminPanelController.titleController,
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
                  controller: adminPanelController.descController,
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
                  controller: adminPanelController.locationController,
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
                Obx(
                  () => GestureDetector(
                    onTap: adminPanelController.pickDateTime,
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
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: grayText,
                          ),
                        ),
                        controller: TextEditingController(
                          text:
                              adminPanelController.selectedDateTime.value ==
                                      null
                                  ? ''
                                  : '${adminPanelController.selectedDateTime.value!.toLocal()}'
                                      .split('.')[0]
                                      .replaceFirst(' ', '  '),
                        ),
                        validator:
                            (v) =>
                                adminPanelController.selectedDateTime.value ==
                                        null
                                    ? 'Date & Time required'
                                    : null,
                      ),
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
                      child: Obx(
                        () => ElevatedButton(
                          onPressed:
                              adminPanelController.isSaving.value
                                  ? null
                                  : () => adminPanelController.saveEvent(
                                    widget.eventToEdit,
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grayText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                          child:
                              adminPanelController.isSaving.value
                                  ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    widget.eventToEdit != null
                                        ? 'Update Event'
                                        : 'Create Event',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
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
