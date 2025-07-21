import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:unity_project/Views/Root/root_screen.dart';
import 'package:unity_project/Views/Welcome/welcome_screen.dart';
import 'package:unity_project/Views/home_screen.dart';
import 'package:unity_project/Views/Login/login_screen.dart';
import 'package:unity_project/Views/register/register_screen.dart';
import 'package:unity_project/models/bindings/auth_bindings.dart';
import 'package:unity_project/middleware/auth_middleware.dart';
import 'package:unity_project/routes/app_routes.dart';
import 'package:unity_project/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
