import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final appService = Get.find<AppService>();
    final user = appService.user;
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await appService.restoreUser();
          Get.log(appService.user.value?.toString() ?? 'No user found');

          // Only show success if user is still logged in
          if (appService.user.value != null) {
            Get.snackbar(
              'Success',
              'Profile refreshed successfully!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green[100],
              colorText: Colors.green[900],
              duration: Duration(seconds: 2),
            );
          }
        } catch (e) {
          Get.log('Refresh failed: $e');
        }
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Container(
              margin: EdgeInsets.all(height * 0.018),
              padding: EdgeInsets.all(height * 0.018),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(height * 0.025),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: height * 0.012,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(
                () => Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: height * 0.06,
                          backgroundImage: AssetImage(
                            'assets/unity_volunteer_logo_noBackground.png',
                          ), // Placeholder
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xff545454).withAlpha(200),
                            child: Icon(
                              Icons.edit,
                              size: height * 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      user.value?.displayName ?? 'Guest Account',
                      style: TextStyle(
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.value?.email ?? 'Guest Account',
                      style: TextStyle(
                        fontSize: height * 0.018,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(label: Text('Top Volunteer')),
                        Chip(label: Text('10+ Events')),
                        // ...more badges
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'Stats',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStat('Events', '12'),
                        _buildStat('Hours', '34'),
                        _buildStat('Badges', '3'),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffedf2f4).withAlpha(200),
                        foregroundColor: Color(0xff545454).withAlpha(200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.editProfile);
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: height * 0.02,
                          color: Color(0xff545454).withAlpha(200),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        Get.find<AppService>().signOut();
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Delete Account'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                backgroundColor: Color(0xffedf2f4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text(
                                  'Delete Account',
                                  style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff545454),
                                  ),
                                ),
                                content: Text(
                                  'Are you sure you want to delete your account?',
                                  style: TextStyle(
                                    fontSize: height * 0.018,
                                    color: Color(0xff545454),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff545454),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await Get.find<AppService>()
                                          .deleteAccount();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // NEW: Email verification status indicator
            Obx(() {
              if (user.value?.newTempEmail != null) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange[800]),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: Text(
                          'Please check your email (${user.value?.newTempEmail}) and click the verification link to complete the email change.',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
