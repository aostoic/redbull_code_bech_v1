import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => NavigationService()),
        ChangeNotifierProvider(create: (_) => CategoriesService()),
        ChangeNotifierProvider(create: (_) => FirebaseService()),
        ChangeNotifierProvider(create: (_) => TournamentService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redbull Code App',
        theme: AppThemes.dark,
        initialRoute: LoadingPage.routeName,
        routes: appRoutes,
      ),
    );
  }
}
