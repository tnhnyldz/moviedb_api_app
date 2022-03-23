import 'package:flutter/material.dart';
import 'package:moviedb_api_app/constants/consts.dart';
import 'package:moviedb_api_app/screens/favoritepage/favorite_page.dart';
import 'package:moviedb_api_app/screens/homepage/HomePage.dart';
import 'package:moviedb_api_app/screens/profilepage/profile_page.dart';
import 'package:moviedb_api_app/screens/searchpage/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  var screens = [HomePage(), FavoritePage(), SearchPage(), ProfilePage()];
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
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_add_outlined,
              ),
              label: 'Favorite',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: 'Profile',
              backgroundColor: Colors.amber),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
