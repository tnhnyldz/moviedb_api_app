import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/firebase_options.dart';
import 'package:moviedb_api_app/screens/authpage/login_page.dart';

import 'constants/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ImageApi.getImages(238);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.background,
        colorScheme: const ColorScheme.dark(primary: Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
