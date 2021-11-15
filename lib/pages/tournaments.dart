import 'package:flutter/material.dart';

class TournamentsPage extends StatelessWidget {
  static String routeName = '/tournaments';

  const TournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TournamentsPage'),
      ),
      body: const Center(
        child: Text('TournamentsPage'),
      ),
    );
  }
}
