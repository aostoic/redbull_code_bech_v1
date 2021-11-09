import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/themes/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redbull Code App',
      theme: AppThemes.dark,
      initialRoute: LoadingPage.routeName,
      routes: appRoutes,
    );
  }
}
