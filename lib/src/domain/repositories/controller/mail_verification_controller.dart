import 'dart:async';

import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;

  final _authRepo = Get.put(AuthenticationRepository());

  @override
  void onInit() {
    super.onInit();
    sendVerificationMail();
    setTimerForAutoRedirect();
  }

  Future<void> sendVerificationMail() async {
    try {
      await _authRepo.sendEmailVerification();
    } catch (e) {
      Helper.errorSnackBar(
          title: "Verification Mail Sending Failed", message: e.toString());
      print(e);
    }
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        _timer.cancel();
        _authRepo.setInitialScreen(user);
      }
    });
  }

  void manuallyCheckEmailVerificationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      _timer.cancel();
      _authRepo.setInitialScreen(user);
    }
  }

 
}
