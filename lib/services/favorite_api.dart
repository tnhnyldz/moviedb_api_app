import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/fav_movie_model.dart';

class FavMovieApi {
  static List<int> favMovieIdList = [];

  Future<List<FavMovieModel>> getFavFilm(int id) async {
    String _url =
        "https://api.themoviedb.org/3/movie/$id?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US";
    List<FavMovieModel> _favList = [];
    var result = await Dio().get(_url);
    var resultList = jsonDecode(jsonEncode(result.data))["result"];

    if (resultList is List) {
      _favList = resultList.map((e) => FavMovieModel.fromJson(e)).toList();
    }

    return _favList;
  }
}
