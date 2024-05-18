import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/constants/storage_strings.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () async {
      await GetStorage().read(StorageStrings.isLoggedIn) == true
          ? Get.offNamed(Routes.HOME)
          : Get.offNamed(Routes.INTRO_SCREENS);
    });
    super.onInit();
  }
}
