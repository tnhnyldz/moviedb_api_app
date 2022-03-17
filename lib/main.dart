import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/main_page.dart';
import 'package:moviedb_api_app/services/character_api.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'constants/consts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // CharacterApi.getCharacter(819);
    // MovieApi.getFilms();
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Constants.background),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MainPage(),
    );
  }
}
