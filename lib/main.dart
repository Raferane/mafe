import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/services/user_service.dart';
import 'package:unity_project/routes/app_routes.dart';
import 'package:unity_project/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(UserService(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.root,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Color(0xffedf2f4),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xff545454),
          selectionHandleColor: Color(0xff545454),
          selectionColor: Color(0xff545454).withAlpha(100),
        ),
      ),
      getPages: appPages,
    );
  }
}
