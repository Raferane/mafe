import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:unity_project/Views/home_screen.dart';
import 'package:unity_project/Views/Login/login_screen.dart';
import 'package:unity_project/Views/register/register_screen.dart';
import 'package:unity_project/models/bindings/auth_bindings.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.green[500],
          elevation: 5,
          shadowColor: Colors.black,
          centerTitle: true,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.green,
          cursorColor: Colors.green,
        ),
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: AuthBindings(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterScreen(),
          binding: AuthBindings(),
        ),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
