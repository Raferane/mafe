import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/adminpanel_controller.dart';
import 'package:unity_project/routes/app_routes.dart';

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
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: adminPanelController.allUsers.length,
                      itemBuilder: (context, index) {
                        final user = adminPanelController.allUsers[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: Icon(
                                Icons.person,
                                color: Colors.green[700],
                              ),
                            ),
                            title: Text(user.displayName ?? ''),
                            subtitle: Text(user.email),
                            trailing: TextButton.icon(
                              icon:
                                  user.isBanned
                                      ? Icon(
                                        Icons.block,
                                        color: Colors.green[400],
                                      )
                                      : Icon(
                                        Icons.block,
                                        color: Colors.red[400],
                                      ),
                              label: Text(
                                user.isBanned ? 'Unban' : 'Ban',
                                style: TextStyle(
                                  color:
                                      user.isBanned
                                          ? Colors.green[400]
                                          : Colors.red[400],
                                ),
                              ),
                              onPressed: () {
                                adminPanelController.banUser(
                                  user.uid,
                                  !user.isBanned,
                                );
                              },
                            ),
                            children: [
                              ListTile(
                                title: Text('Created At: ${user.createdAt}'),
                                // Add more info here
                              ),
                              // Add ban/unban buttons or other actions here
                            ],
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
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: ExpansionTile(
                        leading: Icon(Icons.event, color: Colors.green[700]),
                        title: Text(event.title),
                        subtitle: Text(event.dateTime.toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[400]),
                          onPressed: () {
                            adminPanelController.deleteEvent(event.id);
                          },
                        ),
                        children: [
                          ListTile(
                            title: Text('Created At: ${event.dateTime}'),
                            // Add more info here
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                backgroundColor: Colors.green[700],
                onPressed: () async {
                  final result = await Get.toNamed(AppRoutes.createEventScreen);
                  if (result == true) {
                    await adminPanelController.loadAllEvents();
                  }
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
