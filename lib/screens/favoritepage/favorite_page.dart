import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/fav_movie_model.dart';

import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';

import '../../constants/consts.dart';
import '../../services/favorite_api.dart';

class FavoritePage extends StatefulWidget {
<<<<<<< HEAD
  FavoritePage({Key? key}) : super(key: key);
=======
  const FavoritePage({Key? key}) : super(key: key);

>>>>>>> master
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/movie.png'),
            onPressed: () => exit(0),
          ),
        ],
        title: const Text("Favorites"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          FavMovieModel model1 = FavMovieModel();
          model1 = FavMovieApi.favList[index];
          return Container(
            color: Colors.black,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w300' +
                            model1.backdropPath.toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      model1.title.toString().toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Constants.background2),
                  ),
                  onPressed: () {
                    setState(() {
                      const snackBar = SnackBar(
                        content: Text(
                          'Film removed from Favorites',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      FavMovieApi.favList.removeLast();
                    });
                  },
                  child: const Icon(
                    Icons.bookmark_added_outlined,
                    color: Colors.greenAccent,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: FavMovieApi.favList.length,
      ),
    );
  }
}
