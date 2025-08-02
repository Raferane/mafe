import 'package:get/get.dart';

import '../../controllers/adminpanel_controller.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPanelController>(
      () => AdminPanelController(),
      fenix: true,
    );
  }
}
