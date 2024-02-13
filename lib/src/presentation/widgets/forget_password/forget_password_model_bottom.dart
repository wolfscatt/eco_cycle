import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forget_password_btn_widget.dart';
import 'forget_password_mail.dart';
import 'forget_password_phone.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(
      ThemeData theme, BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: theme.colorScheme.primaryContainer,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Make Selection",
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select the option to reset your password",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(
              height: 30,
            ),
            ForgetPasswordBtnWidget(
              theme: theme,
              icon: Icons.email_outlined,
              title: "Email",
              subtitle: "Reset your password via email",
              onTap: () {
                Get.off(() => ForgetPasswordMailScreen() ) ;

              },
            ),
            SizedBox(
              height: 30,
            ),
            ForgetPasswordBtnWidget(
              theme: theme,
              icon: Icons.phone,
              title: "Phone",
              subtitle: "Reset your password via phone",
              onTap: () {
                 Get.off(() => ForgetPasswordPhoneScreen() ) ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
