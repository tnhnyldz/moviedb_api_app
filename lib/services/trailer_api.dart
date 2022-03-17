import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:moviedb_api_app/model/trailer_player_model.dart';

class TrailerApi {
  static Future<List<PlayerTrailer>> getTrailer(int id) async {
    String _url =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&language=en-US';
    List<PlayerTrailer> _trailerList = [];
    var result = await Dio().get(_url);
    var resultList = jsonDecode(jsonEncode(result.data))["results"];
    if (resultList is List) {
      _trailerList = resultList.map((e) => PlayerTrailer.fromJson(e)).toList();
    }

    return _trailerList;
  }
}
