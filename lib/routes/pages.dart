import 'package:get/get.dart';
import 'package:unity_project/Views/Root/root_screen.dart';
import 'package:unity_project/Views/Welcome/welcome_screen.dart';
import 'package:unity_project/Views/Login/login_screen.dart';
import 'package:unity_project/Views/register/register_screen.dart';
import 'package:unity_project/Views/home_screen.dart';
import 'package:unity_project/models/bindings/auth_bindings.dart';
import 'package:unity_project/middleware/auth_middleware.dart';
import 'app_routes.dart';

final List<GetPage> appPages = [
  GetPage(name: AppRoutes.root, page: () => RootScreen()),
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: AppRoutes.register,
    page: () => RegisterScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => HomeScreen(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.welcome,
    page: () => WelcomeScreen(),
    binding: AuthBindings(),
  ),
];
