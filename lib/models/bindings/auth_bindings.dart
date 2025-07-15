import 'package:get/get.dart';
import 'package:unity_project/controllers/auth_controllers.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
