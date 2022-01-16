import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/modules/home/controllers/home_controller.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);
  Rx<bool> isLoading = RxBool(false);
  static const storage = FlutterSecureStorage();
  String? get email => user.value?.email;
  String? get photoUrl => user.value?.photoURL;
  String? get userName => user.value?.displayName;

  @override
  void onInit() async {
    user.bindStream(firebaseAuth.authStateChanges());
    super.onInit();
  }

  void signInWithEmail() async {
    try {
      isLoading.value = true;
      final String email = emailController.text.toString();
      final String password = passwordController.text.toString();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(
          title: "Invalid credentials",
          message: "User with entered email doesn't exist",
        );
      } else if (e.code == 'wrong-password') {
        showSnackBar(
          title: "Invalid credentials",
          message: "Please enter correct password",
        );
      } else if (e.code == 'too-many-requests') {
        showSnackBar(
          title: "Too many incorrect attempts",
          message: "Try again later",
        );
      } else {
        showSnackBar(title: e.code);
      }
    } catch (e) {
      Get.snackbar("Sorry something went wrong", "");
    }
  }

  void signOut() async {
    try {
      await firebaseAuth.signOut();
      Get.delete<HomeController>();
    } on FirebaseException catch (e) {
      showSnackBar(
        title: "Sorry coudn't Sign Out currently",
        message: e.message,
      );
    } catch (e) {
      showSnackBar(
        title: "Sorry coudn't Sign out",
        message: "Try clearing app data or reinstalling the applicaiton",
      );
    }
  }
}
