import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class MovieApi {
  static const String _url =
      'https://api.themoviedb.org/3/movie/popular?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US&page=1';

  static Future<List<MovieModel>> getFilms() async {
    List<MovieModel> _filmList = [];
    var result = await Dio().get(_url);
    var resultList = jsonDecode(jsonEncode(result.data))["results"];
    // debugPrint(resultList["results"].toString());
    // debugPrint(resultList.toString());
    // var parse = jsonDecode(result.data[0]["page"]);
    if (resultList is List) {
      _filmList = resultList.map((e) => MovieModel.fromJson(e)).toList();
    }

    return _filmList;
  }
}
