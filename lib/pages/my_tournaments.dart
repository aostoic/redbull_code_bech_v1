import 'package:flutter/material.dart';

class MyTournamentsPage extends StatelessWidget {
  static String routeName = '/my-tournaments';

  const MyTournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Torneos'),
      ),
    );
  }
}
