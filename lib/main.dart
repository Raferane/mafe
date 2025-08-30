import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/routes/app_routes.dart';
import 'package:unity_project/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Initialize firebase and app service through the apps lifecycle
  await Firebase.initializeApp();

  final appService = Get.put(AppService(), permanent: true);
  // Global error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    final errorString = details.exception.toString().toLowerCase();
    if (errorString.contains('user-token-expired') ||
        errorString.contains('user-not-found') ||
        errorString.contains('invalid-credential')) {
      // Handle token revocation globally
      appService.handleTokenRevoked();
    }
  };
  await appService.restoreUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Initial route to root
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
      // Routes
      getPages: appPages,
    );
  }
}
