import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_confirm_password_text_field.dart';
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

  void _openUnlockSheet({required bool isGoogleUser}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final viewInsets = MediaQuery.of(ctx).viewInsets;
        final TextEditingController tempCurrentPasswordController =
            TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 24 + viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xff545454).withAlpha(100),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Unlock security changes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                isGoogleUser
                    ? 'For Google accounts, security settings are managed by Google.'
                    : 'Enter your current password to enable editing Email and Password.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              if (!isGoogleUser)
                TextField(
                  controller: tempCurrentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xff545454),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Current password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff545454).withAlpha(100),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff545454).withAlpha(100),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff545454).withAlpha(100),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xff545454),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff545454),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        try {
                          await editProfileController.verifyCurrentPassword(
                            tempCurrentPasswordController.text,
                          );
                          if (!isGoogleUser) {
                            oldPasswordController.text =
                                tempCurrentPasswordController.text;
                            editProfileController.recentPassword.value =
                                tempCurrentPasswordController.text;
                            Get.log(
                              'recentPassword: ${editProfileController.recentPassword.value}',
                            );
                            Future.delayed(Duration(minutes: 5), () {
                              if (editProfileController
                                  .recentPassword
                                  .value
                                  .isNotEmpty) {
                                editProfileController.recentPassword.value = '';
                              }
                            });
                            if (editProfileController
                                .recentPassword
                                .value
                                .isEmpty) {
                              editProfileController.securityUnlocked.value =
                                  false;
                            } else {
                              editProfileController.securityUnlocked.value =
                                  true;
                            }
                          }
                          if (context.mounted) {
                            Navigator.pop(ctx);
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            e.toString(),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[900],
                            duration: Duration(seconds: 2),
                          );
                        }
                      },
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: ZDropDownMenu(
                    width: width,
                    registerCityController: cityController,
                    height: height,
                  ),
                ),

                SizedBox(height: height * 0.02),
                Obx(() {
                  final bool isGoogleUser =
                      appService.user.value?.isGoogle ?? false;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Security header + unlock button
                      Row(
                        children: [
                          Text(
                            'Security',
                            style: TextStyle(
                              color: Color(0xff545454),
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                color: Color(0xff545454),
                                width: 1,
                              ),
                            ),
                            onPressed:
                                isGoogleUser
                                    ? null
                                    : () => _openUnlockSheet(
                                      isGoogleUser: isGoogleUser,
                                    ),
                            icon: Icon(
                              editProfileController.securityUnlocked.value
                                  ? Icons.lock_open
                                  : Icons.lock_outline,
                              color:
                                  isGoogleUser
                                      ? Colors.grey
                                      : (editProfileController
                                              .securityUnlocked
                                              .value
                                          ? Colors.green
                                          : Color(0xff545454)),
                              size: height * 0.02,
                            ),
                            label: Text(
                              editProfileController.securityUnlocked.value
                                  ? 'Unlocked'
                                  : 'Unlock changes',
                              style: TextStyle(
                                color:
                                    isGoogleUser
                                        ? Colors.grey
                                        : (editProfileController
                                                .securityUnlocked
                                                .value
                                            ? Colors.green
                                            : Color(0xff545454)),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      // Pending email verification banner
                      if (appService.user.value?.newTempEmail != null)
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.01),
                          padding: EdgeInsets.all(height * 0.01),
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
                                size: height * 0.02,
                              ),
                              SizedBox(width: height * 0.01),
                              Expanded(
                                child: Text(
                                  'Please check your email (${appService.user.value?.newTempEmail}) and click the verification link to complete the email change.',
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: height * 0.015,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Google accounts hint
                      if (isGoogleUser)
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.01),
                          padding: EdgeInsets.all(height * 0.01),
                          decoration: BoxDecoration(
                            color: Color(0xffedf2f4),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xff545454)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: Colors.red,
                                size: height * 0.02,
                              ),
                              SizedBox(width: height * 0.01),
                              Expanded(
                                child: Text(
                                  'Email and password changes are managed by your Google account.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: height * 0.015,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: height * 0.02),
                      // Email field (gated by unlock)
                      if (!isGoogleUser) ...[
                        AbsorbPointer(
                          absorbing:
                              !editProfileController.securityUnlocked.value,
                          child: ZEditTextField(
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
                        ),
                        if (!editProfileController.securityUnlocked.value)
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Unlock to edit',
                                style: TextStyle(
                                  color: Color(0xff545454).withAlpha(150),
                                  fontSize: height * 0.015,
                                ),
                              ),
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
                      // Change password toggle
                      Opacity(
                        opacity: isGoogleUser ? 0.5 : 1,
                        child: SwitchListTile.adaptive(
                          activeColor: Colors.green.shade400,
                          activeTrackColor: Colors.green.shade100,
                          inactiveTrackColor: Colors.grey.shade400,
                          inactiveThumbColor: Colors.white,
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.grey.shade400,
                          ),
                          title: Text('Change password'),
                          value:
                              editProfileController.wantsToChangePassword.value,
                          onChanged:
                              (!isGoogleUser &&
                                      editProfileController
                                          .securityUnlocked
                                          .value)
                                  ? (val) =>
                                      editProfileController
                                          .wantsToChangePassword
                                          .value = val
                                  : null,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      if (editProfileController
                          .wantsToChangePassword
                          .value) ...[
                        ZEditPasswordTextField(
                          controller: newPasswordController,
                          labelText: 'New Password',
                          isEnabled:
                              editProfileController.securityUnlocked.value &&
                              !isGoogleUser,
                          onDisabledTap: () {
                            Get.snackbar(
                              'Error',
                              'Unlock to change password',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[100],
                              colorText: Colors.red[900],
                              duration: Duration(seconds: 2),
                            );
                          },
                          editProfileController: editProfileController,
                          validator: (value) {
                            if (editProfileController
                                .wantsToChangePassword
                                .value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 8) {
                                  return 'New Password must be at least 8 characters long';
                                }
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        ZEditConfirmPasswordTextField(
                          controller: confirmPasswordController,
                          isEnabled:
                              editProfileController.securityUnlocked.value &&
                              !isGoogleUser,
                          onDisabledTap: () {
                            Get.snackbar(
                              'Error',
                              'Unlock to change password',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[100],
                              colorText: Colors.red[900],
                              duration: Duration(seconds: 2),
                            );
                          },
                          labelText: 'Confirm New Password',
                          editProfileController: editProfileController,
                          validator: (value) {
                            if (editProfileController
                                .wantsToChangePassword
                                .value) {
                              if (value != null && value.isNotEmpty) {
                                if (value != newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  );
                }),
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
                                      newEmail: emailController.text,
                                      currentPassword:
                                          oldPasswordController.text,
                                      oldEmail: currentEmail,
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
                                    "Unexpected Error: $e",
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
