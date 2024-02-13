import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants.dart';
import '../widgets/edit_text_input_widget.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: UpdateProfileBody(),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(LineAwesomeIcons.angle_left),
      ),
      title: Text(
        'Edit Profile',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

class UpdateProfileBody extends StatelessWidget {
  const UpdateProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image(image: AssetImage(defaultUserImage)),
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => UpdateProfile());
                    },
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.yellow),
                        child: Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 20)),
                  ),
                )
              ]),
              SizedBox(height: 70),
              Form(
                  child: Column(
                children: [
                  EditTextInputWidget(labelText: "Full Name", hintText: "Enter Full Name", iconData: Icons.person_outline_rounded),
                  const SizedBox(height: 20),
                  EditTextInputWidget(labelText: "E-Mail", hintText: "Enter E-Mail Address", iconData: Icons.email_outlined),
                  const SizedBox(height: 20),
                  EditTextInputWidget(labelText: "Phone Number", hintText: "Enter Phone Number", iconData: Icons.phone_outlined),
                  const SizedBox(height: 20),
                   SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 231, 18),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
              
                },
                child: Text("Edit Profile".toUpperCase()),
              ),
            )
                ],
              ))
            ],
          ),
        ));
  }
}
