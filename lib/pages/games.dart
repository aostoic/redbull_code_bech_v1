import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class GamesPage extends HookWidget {
  static String routeName = '/games';

  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<GameService>(context);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        service.getGames();
      });
    }, []);

    void goToGame(Game game) {}

    final List<String> titles = [
      for (int i = 0; i < service.games.length; i++) "" //service.games[i].name,
    ];

    final List<Widget> images = [
      for (int i = 0; i < service.games.length; i++)
        Hero(
          tag: service.games[i].id,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(
                  service.games[i].portraitUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Juegos'),
      ),
      body: SafeArea(
        child: Container(
          child: service.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : service.games.isEmpty
                  ? const Center(
                      child: Text(
                        'Aún no se han creado juegos',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.backgroundDarkColor,
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Expanded(
                          child: VerticalCardPager(
                            titles: titles,
                            images: images, // required
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                            ),
                            onPageChanged: (page) {},
                            onSelectedItem: (index) =>
                                goToGame(service.games[index]),
                            initialPage: 0,
                            align: ALIGN.CENTER,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
