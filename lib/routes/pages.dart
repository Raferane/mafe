import 'package:get/get.dart';
import 'package:unity_project/Views/Admin_panel/admin_panel_screen.dart';
import 'package:unity_project/Views/Bottom_screens/Favorites/favorites_screen.dart';
import 'package:unity_project/Views/Bottom_screens/profile/profile_screen.dart';
import 'package:unity_project/Views/Bottom_screens/search/search_screen.dart';
import 'package:unity_project/Views/Root/root_screen.dart';
import 'package:unity_project/Views/Welcome/welcome_screen.dart';
import 'package:unity_project/Views/Login/login_screen.dart';
import 'package:unity_project/Views/register/register_screen.dart';
import 'package:unity_project/Views/home_screen.dart';
import 'package:unity_project/Views/settings/settings_screen.dart';
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
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  GetPage(name: AppRoutes.search, page: () => SearchScreen()),
  GetPage(name: AppRoutes.favorites, page: () => FavoritesScreen()),
  GetPage(name: AppRoutes.adminpanel, page: () => AdminPanelScreen()),
  GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
];
