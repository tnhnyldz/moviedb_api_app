import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class MovieApi {
  // List<String> list = ['popular', 'top_rated','upcoming'];

  static Future<List<MovieModel>> getFilms(String type) async {
    String url =
        'https://api.themoviedb.org/3/movie/$type?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US&page=1';
    List<MovieModel> _filmList = [];
    var result = await Dio().get(url);
    var resultList = jsonDecode(jsonEncode(result.data))["results"];
    // debugPrint(resultList["results"].toString());
    // debugPrint(resultList.toString());
    // var parse = jsonDecode(result.data[0]["page"]);
    if (resultList is List) {
      _filmList = resultList.map((e) => MovieModel.fromJson(e)).toList();
    }
    return _filmList;
  }
  /* static Future<MovieModel> fetchAllDetails(String id) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/' +
        "movie/" +
        id +
        '?api_key=' +
        '7fa59a378e841e63dae9ca6ee8fe2fcf' +
        "&append_to_response=images,videos,credits"));
    var dataDecoded = jsonDecode(response.body);
    return MovieModel.fromDetailsJson(dataDecoded);
  } */

  // static const String _url2 =
  //     'https://api.themoviedb.org/3/movie/?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US&page=1';

}
