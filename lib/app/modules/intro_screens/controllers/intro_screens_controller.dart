import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/all_events.dart';
import '../models/intro_screen_model.dart';

class IntroScreensController extends GetxController {
  @override
  void onClose() {
    introScreensPageController.dispose();
    super.onClose();
  }


  List<IntroScreenData> introScreens = [
    IntroScreenData(
      title: "Discover Amazing Events",
      subtitle: "Explore a wide variety of events happening around you.",
      imagePath: Images.introScreen2,
    ),
    IntroScreenData(
      title: "Personalized Event Suggestions",
      subtitle: "Get recommendations based on your interests.",
      imagePath: Images.introScreen1,
    ),
    IntroScreenData(
      title: "Easy Event Management",
      subtitle: "Organize and manage your events effortlessly.",
      imagePath: Images.introScreen3,
    ),
    IntroScreenData(
      title: "Seamless Ticket Booking",
      subtitle: "Book tickets quickly and securely within the app.",
      imagePath: Images.introScreen4,
    ),
    IntroScreenData(
      title: "Stay Updated and Connected",
      subtitle: "Receive real-time updates and connect with fellow attendees.",
      imagePath: Images.introScreen5,
    ),
  ];
  PageController introScreensPageController = PageController(initialPage: 0);
}
