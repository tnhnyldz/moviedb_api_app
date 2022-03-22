import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/firebase_options.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/main_page.dart';
import 'package:moviedb_api_app/services/character_api.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb_api_app/services/favorite_api.dart';

import 'constants/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    // FavMovieApi.getFavFilm(6);

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
