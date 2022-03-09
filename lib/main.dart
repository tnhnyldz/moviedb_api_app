import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_api_app/screens/homepage/HomePage.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';
import 'package:skeletons/skeletons.dart';

import 'constants/consts.dart';

void main() {
  //Intl.defaultLocale = 'en_EN';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // MovieApi.getFilms();
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Constants.background),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
    );
  }
}
