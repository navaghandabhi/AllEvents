import 'dart:developer';

import 'package:all_events/app/data/all_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/models/user_data_model.dart';
import '../../../data/services/firestore_services.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isSigningIn = false.obs;

  //Sign in with google
  Future<void> signInWithGoogle() async {
    isSigningIn.value = true;
    try {
      final GetStorage storage = GetStorage();
      final FirestoreServices firebaseServices = FirestoreServices();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log("Google Sign In Failed");
        Get.rawSnackbar(message: "Sign In Failed Please Try Again Later");
      } else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          String userId = await firebaseServices.addUser(UserData(
            email: userCredential.user!.email,
            name: userCredential.user!.displayName,
            id: userCredential.user!.uid,
            photoUrl: userCredential.user!.photoURL,
          ));
          log("userId : $userId");
          storage.write(StorageStrings.uid, userId);
          storage.write(
              StorageStrings.displayName, userCredential.user!.displayName);
          storage.write(StorageStrings.isLoggedIn, true);
          Get.offAllNamed(Routes.HOME);
        }
      }
    } catch (error) {
      log("Error : ${error.toString()}");
    } finally {
      isSigningIn.value = false;
    }
  }
}
