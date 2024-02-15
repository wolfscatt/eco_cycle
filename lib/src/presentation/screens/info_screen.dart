import 'package:eco_cycle/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: InformationScreenBody(),
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
        'Information',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

class InformationScreenBody extends StatelessWidget {
  const InformationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(image: AssetImage(logoImage))),
          ),
          InfoText(
              text: 'This is the information screen',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          InfoText(
              text:
                  'This project is prepared for the Solution Challenge 2024 event. The project is designed to raise climate awareness among users.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black)),
          SizedBox(height: 20),
          // Projeyi yapanların bilgileri
          SizedBox(
            height: 138, // Kart yüksekliği
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildTeamMemberCard(
                  context,
                  omerPhoto,
                  'Ömer Faruk BİNGÖL',
                  'https://www.linkedin.com/in/omer-faruk-bingol-33a47a187/',
                ),
                _buildTeamMemberCard(
                  context,
                  defaultUserImage,
                  'Batuhan',
                  'https://www.linkedin.com/in/janesmith/',
                ),
                _buildTeamMemberCard(
                  context,
                  defaultUserImage,
                  'Pembenaz ÇAVDAR',
                  'https://www.linkedin.com/in/alicejohnson/',
                ),
                _buildTeamMemberCard(
                  context,
                  defaultUserImage,
                  'Merve',
                  'https://www.linkedin.com/in/bobbrown/',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(
      BuildContext context, String imagePath, String name, String linkedIn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.blue,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () => launchUrl(Uri.parse(linkedIn)),
                child: Text(
                  'LinkedIn Profile',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
