import 'package:all_events/app/data/all_events.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashScreenController(),
        id: 'splash_screen',
        builder: (_) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                Images.appLogo,
                height: 150,
              ),
            ),
          );
        });
  }
}
