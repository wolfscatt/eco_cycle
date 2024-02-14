import 'dart:async';

import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVerificationMail();
    setTimerForAutoRedirect();
  }

  Future<void> sendVerificationMail() async {
    try {
      await AuthenticationRepository.to.sendEmailVerification();
    } catch (e) {
      Get.snackbar(
          "Error", "Failed to send verification mail: ${e.toString()}");
      print(e);
    }
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        _timer.cancel();
        AuthenticationRepository.to.setInitialScreen(user);
      }
    });
  }

  void manuallyCheckEmailVerificationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      _timer.cancel();
      AuthenticationRepository.to.setInitialScreen(user);
    }
  }
}
