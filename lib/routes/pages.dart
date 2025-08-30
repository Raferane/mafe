import 'package:get/get.dart';
import 'package:unity_project/Views/Admin_panel/admin_panel_screen.dart';
import 'package:unity_project/Views/Admin_panel/events/create_event_screen.dart';
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
import 'package:unity_project/models/bindings/admin_bindings.dart';
import 'package:unity_project/models/bindings/auth_bindings.dart';
import 'package:unity_project/models/bindings/home_bindings.dart';
import 'package:unity_project/middleware/auth_middleware.dart';
import 'package:unity_project/models/bindings/edit_profile_binding.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/Views/about_us/about_us_screen.dart';

final List<GetPage> appPages = [
  GetPage(name: '/', page: () => RootScreen()),
  GetPage(name: '/login', page: () => LoginScreen(), binding: AuthBindings()),
  GetPage(
    name: '/register',
    page: () => RegisterScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    middlewares: [AuthMiddleware()],
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/welcome',
    page: () => WelcomeScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: '/adminpanel',
    page: () => AdminPanelScreen(),
    binding: AdminBindings(),
  ),
  GetPage(name: '/profile', page: () => ProfileScreen()),
  GetPage(name: '/search', page: () => SearchScreen()),
  GetPage(name: '/favorites', page: () => FavoritesScreen()),
  GetPage(
    name: '/editProfile',
    page: () => EditProfileScreen(),
    binding: EditProfileBinding(),
  ),
  GetPage(name: '/adminpanel', page: () => AdminPanelScreen()),
  GetPage(
    name: '/createEventScreen',
    page: () => CreateEventScreens(eventToEdit: Get.arguments as Event?),
  ),

  GetPage(name: '/aboutus', page: () => AboutUsScreen()),
  GetPage(name: '/contactus', page: () => ContactUsScreen()),
  GetPage(name: '/eventDetail', page: () => EventDetail()),
];
