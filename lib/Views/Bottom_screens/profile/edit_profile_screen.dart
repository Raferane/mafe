import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Bottom_screens/profile/components/z_edit_text_field.dart';
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
  final AppService appService = Get.find();
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
                if (isGoogleUser == false) {
                  return ZEditTextField(
                    controller: emailController,
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  );
                } else {
                  return Container(
                    height: height * 0.06,
                    width: width * 0.8,
                    child: Text('Email is not available for Google users'),
                  );
                }
              }),
              MaterialButton(
                color: Color(0xff545454),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  await appService.editUser(appService.user.value!.uid, {
                    "displayName": nameController.text,
                  });
                  Get.back();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.046,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
