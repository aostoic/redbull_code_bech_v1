import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class TournamentsPage extends StatelessWidget {
  static String routeName = '/tournaments';

  const TournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      for (int i = 0; i < tournamentsDummyData.length; i++)
        tournamentsDummyData[i].title,
    ];

    final List<Widget> images = [
      for (int i = 0; i < tournamentsDummyData.length; i++)
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(
                tournamentsDummyData[i].urlImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
                titles: titles, // required
                images: images, // required
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
                onPageChanged: (page) {},
                onSelectedItem: (index) {},
                initialPage: 0,
                align: ALIGN.CENTER,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
