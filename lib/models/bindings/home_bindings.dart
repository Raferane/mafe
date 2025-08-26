import 'package:get/get.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/controllers/search_controller.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/models/services/event_repository.dart';
import 'package:unity_project/models/services/favorites_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventRepository>(() => EventRepository());
    Get.lazyPut<FavoritesRepository>(() => FavoritesRepository());
    Get.put<HomeController>(
      HomeController(Get.find(), Get.find(), Get.find<AppService>()),
    );
    Get.put<SearchController>(SearchController(Get.find()));
  }
}
