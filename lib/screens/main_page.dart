import 'package:flutter/material.dart';
import 'package:moviedb_api_app/constants/consts.dart';
import 'package:moviedb_api_app/screens/favoritepage/favorite_page.dart';
import 'package:moviedb_api_app/screens/homepage/HomePage.dart';
import 'package:moviedb_api_app/screens/profilepage/profile_page.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';
import 'package:moviedb_api_app/services/character_api.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  var screens = [HomePage(), ProfilePage(), FavoritePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Constants.background,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        selectedFontSize: 19,
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        // showUnselectedLabels: false,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorite',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: 'Profile',
              backgroundColor: Colors.red),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
