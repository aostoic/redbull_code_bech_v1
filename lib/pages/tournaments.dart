import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class TournamentsPage extends StatelessWidget {
  static String routeName = '/tournaments';

  const TournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesService = Provider.of<CategoriesService>(
      context,
      listen: false,
    );

    final List<String> titles = [
      "MARIO KART",
      "FIFA 2021",
      "MARIO KART",
      "FIFA 2021"
    ];

    // final result =  categoriesService.getCategories();
    // result.forEach((res) {
    //   titles.add(res['name']);
    // });

    final List<Widget> images = [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/redbull-code-bech.appspot.com/o/unnamed.png?alt=media&token=7c4a3568-41a4-4790-ad87-3e4714ac82d4"),
                fit: BoxFit.cover)),
      ),
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/redbull-code-bech.appspot.com/o/1595430681_FIFA-21-dio-a-conocer-la-portada-oficial-protagonizada-por.png?alt=media&token=f58a4e9d-dae7-4570-a78e-e0aeb0cd4df8"),
                fit: BoxFit.cover)),
      ),
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/redbull-code-bech.appspot.com/o/unnamed.png?alt=media&token=7c4a3568-41a4-4790-ad87-3e4714ac82d4"),
                fit: BoxFit.cover)),
      ),
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/redbull-code-bech.appspot.com/o/1595430681_FIFA-21-dio-a-conocer-la-portada-oficial-protagonizada-por.png?alt=media&token=f58a4e9d-dae7-4570-a78e-e0aeb0cd4df8"),
                fit: BoxFit.cover)),
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
              child: Container(
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: TextStyle(
                      color: Colors.white,
                    ), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
