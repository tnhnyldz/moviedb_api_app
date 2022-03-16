import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:moviedb_api_app/model/character_model.dart';

class CharacterApi {
  static Future<List<CharacterModel>> getCharacter(int id) async {
    String _url =
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=eddcfa9435e7f4885b7f6ba93354b3f2&language=en-US';
    List<CharacterModel> _characterList = [];
    var result = await Dio().get(_url);
    var resultList = jsonDecode(jsonEncode(result.data))["cast"];

    if (resultList is List) {
      _characterList =
          resultList.map((e) => CharacterModel.fromJson(e)).toList();
    }
    return _characterList;
  }
}
