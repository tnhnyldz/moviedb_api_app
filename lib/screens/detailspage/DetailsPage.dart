// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_api_app/model/character_model.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';

import '../../constants/consts.dart';
import '../Widgets/popularRow.dart';
import 'package:moviedb_api_app/services/character_api.dart';

class DetailsPage extends StatefulWidget {
  final MovieModel currentMovie;
  CharacterModel? currentCharacter;

  DetailsPage(this.currentMovie);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<List<MovieModel>> _recList;
  late Future<List<CharacterModel>> _characterList;
  @override
  void initState() {
    super.initState();
    _recList = MovieApi.getRecommendations(widget.currentMovie.id!);
    _characterList = CharacterApi.getCharacter(widget.currentMovie.id!);
  }

  @override
  Widget build(BuildContext context) {
    CharacterApi.getCharacter(widget.currentMovie.id!);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 510,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(
              //   widget.title.toString(),
              // ),
              background: Image.network(
                // "https://source.unsplash.com/812jL3jmV1w",
                "https://image.tmdb.org/t/p/w500" +
                    widget.currentMovie.posterPath.toString(),
                scale: 1.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 150,
                  color: Colors.black,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    widget.currentMovie.title.toString(),
                    style: GoogleFonts.lora(
                      textStyle: const TextStyle(
                        backgroundColor: Colors.black,
                        color: Colors.white,
                        letterSpacing: .7,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 160,
                  color: Colors.black,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.currentMovie.overview.toString(),
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          backgroundColor: Colors.black,
                          color: Colors.white,
                          letterSpacing: .7,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.black,
                  child: RateBarDetails(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Cast",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: .7,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  width: 200,
                  height: 150,
                  color: Colors.black38,
                  child: FutureBuilder<List<CharacterModel>>(
                    future: _characterList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CharacterModel> _chrList = snapshot.data!;
                        return ListView.builder(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            var activeCast = _chrList[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: activeCast
                                                    .profilePath !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    activeCast.profilePath
                                                        .toString(),
                                              )
                                            : const CachedNetworkImageProvider(
                                                'https://www.seekpng.com/png/detail/297-2978586_rono-daniel-empty-profile-picture-icon.png'),
                                        radius: 50,
                                      ),
                                      Text(
                                        activeCast.name.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Recommended",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: .7,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 330,
                  color: Colors.black,
                  child: FutureBuilder<List<MovieModel>>(
                    future: _recList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<MovieModel> _listem = snapshot.data!;

                        return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var currentFilm = _listem[index];
                            return RecList(context, currentFilm);
                          },
                          itemCount: 10,
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("dasta yok"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 15, bottom: 15),
                //   width: 200,
                //   height: 150,
                //   color: Colors.black38,
                //   child: FutureBuilder<List<CharacterModel>>(
                //     future: _characterList,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         List<CharacterModel> _chrList = snapshot.data!;
                //         return ListView.builder(
                //           //padding: const EdgeInsets.symmetric(horizontal: 10),
                //           scrollDirection: Axis.horizontal,
                //           itemCount: 5,
                //           itemBuilder: (context, index) {
                //             var activeCast = _chrList[index];
                //             return Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Container(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 10),
                //                   child: Column(
                //                     children: [
                //                       CircleAvatar(
                //                         backgroundImage: activeCast
                //                                     .profilePath !=
                //                                 null
                //                             ? CachedNetworkImageProvider(
                //                                 'https://image.tmdb.org/t/p/w500' +
                //                                     activeCast.profilePath
                //                                         .toString(),
                //                               )
                //                             : const CachedNetworkImageProvider(
                //                                 'https://www.seekpng.com/png/detail/297-2978586_rono-daniel-empty-profile-picture-icon.png'),
                //                         radius: 50,
                //                       ),
                //                       Text(
                //                         activeCast.name.toString(),
                //                         style: const TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 15),
                //                       ),
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             );
                //           },
                //         );
                //       } else {
                //         return const CircularProgressIndicator();
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row RateBarDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          height: 100,
          color: Colors.black,
          child: Column(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 40.0,
              ),
              const Text(
                "Vote:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.currentMovie.voteAverage.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(6.0),
            height: 100,
            color: Colors.black,
            child: Column(
              children: [
                const Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 40.0,
                ),
                const Text(
                  "language:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.currentMovie.originalLanguage.toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
        Container(
          height: 100,
          color: Colors.black,
          padding: EdgeInsets.all(6.0),
          child: Column(
            children: [
              const Icon(
                Icons.date_range,
                color: Colors.white,
                size: 40.0,
              ),
              const Text(
                "Year",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                DateFormat.y().format(
                  DateTime.parse(
                    widget.currentMovie.releaseDate.toString(),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox RecList(BuildContext context, MovieModel currentFilm) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .40,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Constants.background2,
            ),
            height: 292,
            // color: Constants.background2,
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.red,
                  width: 150,
                  height: 120,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500" +
                        currentFilm.backdropPath.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  currentFilm.title.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      onRatingUpdate: (rating) => setState(() {
                        widget.currentMovie.voteAverage = rating;
                      }),
                      allowHalfRating: true,
                      unratedColor: Colors.blueGrey.shade200,
                      itemCount: 5,
                      initialRating:
                          (currentFilm.voteAverage!.toDouble() / 2) - 0.5,
                      itemSize: 16,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Icon(Icons.star_border_outlined),
                    Text(
                      "Yayın Yılı: " +
                          DateFormat.y().format(
                            DateTime.parse(
                              currentFilm.releaseDate.toString(),
                            ),
                          ),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      "Popülerlik: " + currentFilm.popularity.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      "Puan: " +
                          (currentFilm.voteAverage!.toDouble() / 2)
                              .toStringAsFixed(1),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (detailsContext) => DetailsPage(currentFilm),
                      ),
                    );
                  },
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 14, color: Constants.background),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
