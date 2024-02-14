import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/controller/profile_controller.dart';
import '../../utils/constants.dart';
import '../pages/profile_page.dart';
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
          Get.off(() => ProfilePage());
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
    final controller = Get.put(ProfileController());
    return Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final id = user.id;
                  final email = TextEditingController(text: user.email);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNumber = TextEditingController(text: user.phoneNumber);
                  final password = TextEditingController(text: user.password);
                  final photoUrl = user.photoURL;
                  return Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Image(
                                  image: getImage(user), fit: BoxFit.cover),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // Kullanıcı fotoğrafı değiştirme
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
                          EditTextInputWidget(
                              controller: fullName,
                              labelText: "Full Name",
                              hintText: "Enter Full Name",
                              iconData: Icons.person_outline_rounded),
                          const SizedBox(height: 20),
                          EditTextInputWidget(
                              controller: email,
                              labelText: "E-Mail",
                              hintText: "Enter E-Mail Address",
                              iconData: Icons.email_outlined),
                          const SizedBox(height: 20),
                          EditTextInputWidget(
                              controller: phoneNumber,
                              labelText: "Phone Number",
                              hintText: "Enter Phone Number",
                              iconData: Icons.phone_outlined),
                          const SizedBox(height: 20),
                          PasswordWidget(
                              controller: controller, password: password),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 231, 18),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () async {
                                final userData = UserModel(
                                    fullName: fullName.text.trim(),
                                    email: email.text.trim(),
                                    phoneNumber: phoneNumber.text.trim(),
                                    password: password.text.trim(),
                                    photoURL: photoUrl);

                                await controller.updateUser(userData, id);
                              },
                              child: Text("Edit Profile".toUpperCase()),
                            ),
                          )
                        ],
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: Text("No Data"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  getImage(UserModel userData) {
    if (userData.photoURL != null) {
      return NetworkImage(userData.photoURL!);
    } else {
      return AssetImage(defaultUserImage);
    }
  }
}

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required this.controller,
    required this.password,
  });

  final ProfileController controller;
  final TextEditingController password;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.controller.obsecureText.value,
      controller: widget.password,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.fingerprint),
        labelText: "Password",
        hintText: "Enter Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye_sharp),
          onPressed: () {
            setState(() {
              widget.controller.obsecureText.toggle();
              print("Text gizleme: ${widget.controller.obsecureText.value}");
            });
          },
        ),
      ),
    );
  }
}
