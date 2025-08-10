import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/adminpanel_controller.dart';
import 'package:unity_project/Views/Admin_panel/admin_components/user_expansion_tile.dart';
import 'package:unity_project/Views/Admin_panel/admin_components/event_expansion_tile.dart';

class AdminTabBarView extends StatelessWidget {
  AdminTabBarView({super.key});
  final AdminPanelController adminPanelController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Users Tab
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () =>
                adminPanelController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: adminPanelController.allUsers.length,
                      itemBuilder: (context, index) {
                        final user = adminPanelController.allUsers[index];
                        return UserExpansionTile(
                          user: user,
                          onBanUser:
                              () => adminPanelController.banUser(
                                user.uid,
                                !user.isBanned,
                              ),
                        );
                      },
                    ),
          ),
        ),

        // Events Tab
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => ListView.builder(
                  itemCount: adminPanelController.allEvents.length,
                  itemBuilder: (context, index) {
                    final event = adminPanelController.allEvents[index];
                    return EventExpansionTile(
                      event: event,
                      onEdit: () => adminPanelController.editEvent(event),
                      onDelete:
                          () => adminPanelController.showDeleteDialog(event),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: adminPanelController.createNewEvent,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
