// To parse this JSON data, do
//
//     final playerTrailer = playerTrailerFromJson(jsonString);

import 'dart:convert';

PlayerTrailer playerTrailerFromJson(String str) =>
    PlayerTrailer.fromJson(json.decode(str));

String playerTrailerToJson(PlayerTrailer data) => json.encode(data.toJson());

class PlayerTrailer {
  PlayerTrailer({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  factory PlayerTrailer.fromJson(Map<String, dynamic> json) => PlayerTrailer(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        //"published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
        "id": id,
      };
}
