import 'package:flutter_svg/svg.dart';

import '../../../data/all_events.dart';
import '../../../routes/app_pages.dart';
import '../controllers/intro_screens_controller.dart';
import '../models/intro_screen_model.dart';

class IntroScreensView extends GetView<IntroScreensController> {
  const IntroScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            child: PageView.builder(
                itemCount: controller.introScreens.length,
                controller: controller.introScreensPageController,
                itemBuilder: (context, index) {
                  final IntroScreenData screen = controller.introScreens[index];
                  return Container(
                    key: ValueKey(controller.introScreens[index]),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(screen.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            screen.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            screen.subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 64),
                          _buttons(index),
                          const SizedBox(height: 64),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            top: 64,
            left: 32,
            child: SvgPicture.asset(
              Images.appLogoRow,
              width: Get.width * 0.4,
            ),
          )
        ],
      ),
    );
  }

  Widget _buttons(int index) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              if (index == 0) {
                Get.toNamed(Routes.LOGIN);
              } else {
                controller.introScreensPageController.previousPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(index == 0 ? "Skip" : "Back",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          const SizedBox(width: 32),
          CustomButton(
            onPressed: () {
              if (index == controller.introScreens.length - 1) {
                Get.toNamed(Routes.LOGIN);
              } else {
                controller.introScreensPageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              }
            },
            label: index == controller.introScreens.length - 1
                ? "Get Started"
                : "Next",
          ),
        ],
      ),
    );
  }
}
