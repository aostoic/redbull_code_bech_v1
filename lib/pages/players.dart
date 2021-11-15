import 'package:flutter/material.dart';

class PlayersPage extends StatelessWidget {
  static String routeName = '/players';

  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayersPage'),
      ),
      body: const Center(
        child: Text('PlayersPage'),
      ),
    );
  }
}
