import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviedb_api_app/model/Movie_Model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieApi {
  static const String _url =
      'https://api.themoviedb.org/3/movie/popular?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US&page=1';

  static Future<List<MovieModel>> getFilms() async {
    List<MovieModel> _list = [];

    var result = await Dio().get(_url);
    var list = jsonDecode(result.data);
    debugPrint(list.toString());

    return _list;
  }
}
