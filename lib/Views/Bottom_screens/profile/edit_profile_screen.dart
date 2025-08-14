import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_confirm_password_text_field.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_old_password_text_field.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_password_text_field.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_text_field.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_google_text_form_field.dart';
import 'package:unity_project/Views/register/components/z_drop_down_menu.dart';
import 'package:unity_project/controllers/edit_profile_controller.dart';
import 'package:unity_project/models/services/app_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppService appService = Get.find();
  final EditProfileController editProfileController = Get.find();
  @override
  void initState() {
    super.initState();
    nameController.text = appService.user.value?.displayName ?? '';
    emailController.text = appService.user.value?.email ?? '';
    cityController.text = appService.user.value?.city ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Text(
                  'Edit your profile information',
                  style: TextStyle(
                    color: Color(0xff545454),
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.1),
                ZEditTextField(
                  controller: nameController,
                  labelText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (value.length < 3) {
                      return 'Name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Obx(() {
                  final isGoogleUser = appService.user.value?.isGoogle;
                  return Column(
                    children: [
                      if (isGoogleUser == false) ...[
                        ZEditTextField(
                          controller: emailController,
                          labelText: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Invalid email address';
                            }
                            return null;
                          },
                        ),
                        // Show verification status if there's a pending email
                        if (appService.user.value?.newTempEmail != null)
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xffedf2f4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xff545454)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.red.shade400,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Please check your email (${appService.user.value?.newTempEmail}) and click the verification link to complete the email change.',
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ] else ...[
                        ZGoogleTextField(
                          controller: emailController,
                          labelText: 'Email',
                          onDisabledTap: () {
                            Get.snackbar(
                              'Error',
                              'Email changes are managed by your Google account',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[100],
                              colorText: Colors.red[900],
                              duration: Duration(seconds: 2),
                            );
                          },
                        ),
                      ],
                      SizedBox(height: height * 0.02),
                      ZEditOldPasswordTextField(
                        isEnabled: isGoogleUser == false,
                        controller: oldPasswordController,
                        labelText: 'Old Password',
                        editProfileController: editProfileController,
                        onDisabledTap: () {
                          Get.snackbar(
                            'Error',
                            'Old Password is required for non-Google users',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[900],
                            duration: Duration(seconds: 2),
                          );
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 8) {
                              return 'Old Password must be at least 8 characters long';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      ZEditPasswordTextField(
                        controller: newPasswordController,
                        labelText: 'New Password',
                        isEnabled: isGoogleUser == false,
                        onDisabledTap: () {
                          Get.snackbar(
                            'Error',
                            'New Password is required for non-Google users',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[900],
                            duration: Duration(seconds: 2),
                          );
                        },
                        editProfileController: editProfileController,
                        validator: (value) {
                          if (oldPasswordController.text.isNotEmpty) {
                            if (value == null || value.isEmpty) {
                              return 'New Password is required';
                            } else if (value.length < 8) {
                              return 'New Password must be at least 8 characters long';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      ZEditConfirmPasswordTextField(
                        controller: confirmPasswordController,
                        isEnabled: isGoogleUser == false,
                        onDisabledTap: () {
                          Get.snackbar(
                            'Error',
                            'Confirm New Password is required for non-Google users',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[900],
                            duration: Duration(seconds: 2),
                          );
                        },
                        labelText: 'Confirm New Password',
                        editProfileController: editProfileController,
                        validator: (value) {
                          if (oldPasswordController.text.isNotEmpty) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm New Password is required';
                            } else if (value != newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                }),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ZDropDownMenu(
                    width: width,
                    registerCityController: cityController,
                    height: height,
                  ),
                ),
                SizedBox(height: height * 0.02),
                // S A V E  B U T T O N
                Obx(() {
                  final isLoading = appService.isLoading;

                  return MaterialButton(
                    color: Color(0xff545454),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed:
                        isLoading.value
                            ? null
                            : () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  isLoading.value = true;

                                  final isGoogleUser =
                                      appService.user.value?.isGoogle ?? false;
                                  final currentEmail =
                                      appService.user.value?.email ?? "";
                                  final currentName =
                                      appService.user.value?.displayName ?? "";
                                  final currentCity =
                                      appService.user.value?.city ?? "";

                                  bool emailUpdated = false;
                                  bool profileUpdated = false;
                                  bool passwordUpdated = false;
                                  if (!isGoogleUser &&
                                      currentEmail != emailController.text) {
                                    await editProfileController.editEmail(
                                      emailController.text,
                                    );
                                    emailUpdated = true;
                                  }
                                  if (currentName != nameController.text ||
                                      currentCity != cityController.text) {
                                    await editProfileController
                                        .editUser(appService.user.value!.uid, {
                                          "displayName": nameController.text,
                                          "city": cityController.text,
                                        });
                                    profileUpdated = true;
                                  }
                                  if (oldPasswordController.text.isNotEmpty &&
                                      newPasswordController.text.isNotEmpty &&
                                      confirmPasswordController
                                          .text
                                          .isNotEmpty) {
                                    await editProfileController.changePassword(
                                      currentPassword:
                                          oldPasswordController.text,
                                      newPassword: newPasswordController.text,
                                    );
                                    passwordUpdated = true;
                                  }
                                  Get.log(
                                    "profileUpdated: $profileUpdated, emailUpdated: $emailUpdated, passwordUpdated: $passwordUpdated",
                                  );
                                  if (profileUpdated &&
                                      emailUpdated &&
                                      passwordUpdated) {
                                    Get.snackbar(
                                      'Success',
                                      "Profile updated successfully, an email has been sent to ${appService.user.value?.newTempEmail} to verify the new email",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[100],
                                      colorText: Colors.green[900],
                                      duration: Duration(seconds: 2),
                                    );
                                  } else if (profileUpdated) {
                                    Get.snackbar(
                                      'Success',
                                      "Profile updated successfully",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[100],
                                      colorText: Colors.green[900],
                                      duration: Duration(seconds: 2),
                                    );
                                  } else if (emailUpdated) {
                                    Get.snackbar(
                                      'Success',
                                      "Verification email has been sent to ${appService.user.value?.newTempEmail} to verify the new email",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[100],
                                      colorText: Colors.green[900],
                                      duration: Duration(seconds: 2),
                                    );
                                  } else if (passwordUpdated) {
                                    Get.snackbar(
                                      'Success',
                                      "Password updated successfully",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[100],
                                      colorText: Colors.green[900],
                                      duration: Duration(seconds: 2),
                                    );
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    'Error',
                                    "Unexpected Error",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red[100],
                                    colorText: Colors.red[900],
                                    duration: Duration(seconds: 3),
                                  );
                                  Get.log("Unexpected Error: $e");
                                } finally {
                                  isLoading.value = false;
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  confirmPasswordController.clear();
                                }
                              }
                            },
                    child:
                        isLoading.value
                            ? SizedBox(
                              width: width * 0.046,
                              height: width * 0.046,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.046,
                              ),
                            ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
