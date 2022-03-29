import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  String? backdropPath;
  int? id;
  String? originalTitle;
  String? posterPath;
  String? title;
  Images? images;

  ImageModel({
    this.backdropPath,
    this.id,
    this.originalTitle,
    this.posterPath,
    this.title,
    this.images,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        title: json["title"],
        images: Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "title": title,
        "images": images!.toJson(),
      };
}

class Images {
  Images({
    this.backdrops,
  });

  List<Backdrop>? backdrops;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        backdrops: List<Backdrop>.from(
          json["backdrops"].map(
            (x) => Backdrop.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "backdrops": List<dynamic>.from(backdrops!.map((x) => x.toJson())),
      };
}

class Backdrop {
  Backdrop({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"].toDouble(),
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
