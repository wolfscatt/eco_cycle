import 'package:eco_cycle/src/presentation/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/profile_controller.dart';
import '../../utils/constants.dart';
import '../screens/info_screen.dart';
import '../widgets/profile_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: ProfilePageBody(),
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
        'Profile',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({
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
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      children: [
                        Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child:
                                    Image(image: AssetImage(defaultUserImage)),
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
                                  child: Icon(LineAwesomeIcons.alternate_pencil,
                                      color: Colors.black, size: 20)),
                            ),
                          )
                        ]),
                        SizedBox(height: 20),
                        Text(
                          userData.fullName ?? "User Name",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              Get.to(() => UpdateProfile());
                            },
                            child: Text("Edit Profile")),
                        SizedBox(height: 30),
                        Divider(),
                        SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: "Information",
                            icon: LineAwesomeIcons.info,
                            onPress: () {
                              Get.to(() => InformationScreen());
                            }),
                        SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: "Log Out",
                            icon: LineAwesomeIcons.alternate_sign_out,
                            textColor: Colors.red,
                            onPress: () {
                              controller.signOut();
                            }),
                        SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: "Delete Account",
                            textColor: Colors.red,
                            icon: LineAwesomeIcons.trash,
                            onPress: () {
                              //controller.deleteAccount();
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Column(
                      children: [
                        Text("Error: ${snapshot.error}"),
                        ElevatedButton(
                            onPressed: () {
                              controller.signOut();
                            },
                            child: Text("Sign Out"))
                      ],
                    ));
                  } else {
                    return Center(
                      child: Column(
                      children: [
                        Text("Error"),
                        ElevatedButton(
                            onPressed: () {
                              controller.signOut();
                            },
                            child: Text("Sign Out"))
                      ],
                    ));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
