import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/image_model.dart';


class ImageApi {
  static Future<List<Backdrop>> getImages(int id) async {
    String url =
        "https://api.themoviedb.org/3/movie/$id?api_key=7fa59a378e841e63dae9ca6ee8fe2fcf&append_to_response=images";

    List<Backdrop> _imageList = [];

    var result = await Dio().get(url);
    var resultList = jsonDecode(jsonEncode(result.data))["images"]["backdrops"];
    // debugPrint(resultList.toString());
    if (resultList is List) {
      _imageList = resultList.map((e) => Backdrop.fromJson(e)).toList();
    }
    debugPrint("----------------------");
    debugPrint(_imageList[0].aspectRatio.toString());
    debugPrint(_imageList[0].height.toString());
    debugPrint(_imageList[0].iso6391.toString());
    debugPrint(_imageList[0].filePath.toString());
    debugPrint(_imageList[0].voteAverage.toString());
    debugPrint(_imageList[0].voteCount.toString());
    debugPrint(_imageList[0].width.toString());
    return _imageList;
  }
}
