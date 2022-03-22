import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/main_page.dart';

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
    // CharacterApi.getCharacter(819);s
    // SearchApi.getSearchedFilms('Babam');
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Constants.background),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const MainPage(),
    );
  }
}
