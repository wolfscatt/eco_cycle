import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_repository.dart';

class OTPController extends GetxController {
  static OTPController get to => Get.find();

  RxString otp = "".obs;

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.to.verifyOTP(otp);
    isVerified ? Get.offAll(() => HomePage()) : Get.back();
  }
}
