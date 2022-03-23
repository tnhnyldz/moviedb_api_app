import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/fav_movie_model.dart';

class FavMovieApi {
  static List<FavMovieModel> favList = [];

  static Future<List<FavMovieModel>> getFavFilm(int id) async {
    String _url =
        "https://api.themoviedb.org/3/movie/$id?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US";

    var result = await Dio().get(_url);
    var resultList = jsonDecode(jsonEncode(result.data));
    debugPrint(resultList.toString());
    favList.add(FavMovieModel.fromJson(resultList));
    debugPrint(favList.length.toString());

    return favList;
  }
}
