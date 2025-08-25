import 'package:get/get.dart';
import 'package:unity_project/Views/Admin_panel/admin_panel_screen.dart';
import 'package:unity_project/Views/Admin_panel/events/creat_ event_screen.dart';
import 'package:unity_project/Views/Bottom_screens/Favorites/favorites_screen.dart';
import 'package:unity_project/Views/Bottom_screens/profile/edit_profile_screen.dart';
import 'package:unity_project/Views/Bottom_screens/profile/profile_screen.dart';
import 'package:unity_project/Views/Bottom_screens/search/search_screen.dart';
import 'package:unity_project/Views/Root/root_screen.dart';
import 'package:unity_project/Views/Welcome/welcome_screen.dart';
import 'package:unity_project/Views/Login/login_screen.dart';
import 'package:unity_project/Views/contact_us/contact_us_screen.dart';
import 'package:unity_project/Views/home/home_components/event_detail.dart';
import 'package:unity_project/Views/register/register_screen.dart';
import 'package:unity_project/Views/Home/home_screen.dart';
import 'package:unity_project/Views/settings/settings_screen.dart';
import 'package:unity_project/models/bindings/admin_bindings.dart';
import 'package:unity_project/models/bindings/auth_bindings.dart';
import 'package:unity_project/models/bindings/home_bindings.dart';
import 'package:unity_project/middleware/auth_middleware.dart';
import 'package:unity_project/models/bindings/edit_profile_binding.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/Views/about_us/about_us_screen.dart';
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
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.welcome,
    page: () => WelcomeScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: AppRoutes.adminpanel,
    page: () => AdminPanelScreen(),
    binding: AdminBindings(),
  ),
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  GetPage(name: AppRoutes.search, page: () => SearchScreen()),
  GetPage(name: AppRoutes.favorites, page: () => FavoritesScreen()),
  GetPage(
    name: AppRoutes.editProfile,
    page: () => EditProfileScreen(),
    binding: EditProfileBinding(),
  ),
  GetPage(name: AppRoutes.adminpanel, page: () => AdminPanelScreen()),
  GetPage(
    name: AppRoutes.createEventScreen,
    page: () => CreateEventScreens(eventToEdit: Get.arguments as Event?),
  ),
  GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
  GetPage(name: AppRoutes.aboutus, page: () => AboutUsScreen()),
  GetPage(name: AppRoutes.contactus, page: () => ContactUsScreen()),
  GetPage(name: AppRoutes.eventDetail, page: () => EventDetail()),
];
