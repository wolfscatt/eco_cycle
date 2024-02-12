import 'package:eco_cycle/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(
                Icons.stars_rounded,
                color: Colors.black,
              ),
              Text(
                "500",
                style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        title: Text(
          appName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
            child: IconButton(
                onPressed: () {
                  print("Profile Page");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                icon: Icon(Icons.person_4_outlined)),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.grey[300],
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2023/09/25/12/41/desert-8274886_1280.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add Photo");
        },
        child: Icon(Icons.add_a_photo_outlined),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
