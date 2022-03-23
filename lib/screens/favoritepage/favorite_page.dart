import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const CustomAppBar(),
      Container(
        color: Colors.amber,
        child: const Center(
          child: Text(
            'Favorite Page',
            style: TextStyle(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    ]);
  }
}
