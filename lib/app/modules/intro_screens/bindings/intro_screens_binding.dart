import 'package:get/get.dart';

import '../controllers/intro_screens_controller.dart';

class IntroScreensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroScreensController>(
      () => IntroScreensController(),
    );
  }
}
