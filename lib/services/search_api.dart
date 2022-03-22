import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:moviedb_api_app/model/movie_model.dart';

class SearchApi {
  static Future<List<MovieModel>> getSearchedFilms(String search) async {
    String url =
        'https://api.themoviedb.org/3/search/multi?api_key=eddcfa9435e7f4885b7f6ba93354b3f2&language=en-US&query=$search&page=1&include_adult=false';
    List<MovieModel> _filmList = [];
    var result = await Dio().get(url);
    var resultList = jsonDecode(jsonEncode(result.data))["results"];

    if (resultList is List) {
      _filmList = resultList.map((e) => MovieModel.fromJson(e)).toList();
    }
    return _filmList;
  }
}
