import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  Future<void> _redirectToDonationSite() async {
    final Uri url = Uri.parse(
        'https://www.tema.org.tr/bagislar'); // Buraya bağış sitesi URL'sini girin
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _redirectToDonationSite(),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/images/tema-logo.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tema Vakfı',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            color: Colors.black,
                          ),
                          Text(
                            '5000 Point',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
