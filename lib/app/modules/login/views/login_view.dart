import 'package:all_events/app/data/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/all_events.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(Images.introScreen5), fit: BoxFit.cover, opacity: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              // SizedBox(height: ),
              Image.asset(
                Images.appLogo,
                height: 150,
              ),
              const Text(
                'Discover amazing places in the world with us and enjoy your time',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.1),
              //Sign in with google
              _signInButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlinedButton.icon(
      icon: SvgPicture.asset(
        Images.googleLogo,
        height: 32,
      ),
      onPressed: controller.signInWithGoogle,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      label: const Text("Sign In with Google", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ).toProgressIndicator(controller.isSigningIn);
  }
}
