
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_api_app/model/character_model.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/model/trailer_player_model.dart';
import 'package:moviedb_api_app/screens/Widgets/youtube_player.dart';
import 'package:moviedb_api_app/services/character_api.dart';
import 'package:moviedb_api_app/services/images_api.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';
import 'package:moviedb_api_app/services/trailer_api.dart';

import '../../constants/consts.dart';
import '../../model/image_model.dart';
import '../../services/favorite_api.dart';

class DetailsPage extends StatefulWidget {
  final MovieModel currentMovie;
  

  const DetailsPage(this.currentMovie, {Key? key}) : super(key: key);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<List<MovieModel>> _recList;
  late Future<List<CharacterModel>> _characterList;
  late Future<List<PlayerTrailer>> _playerList;
  late Future<List<Backdrop>> _backdropList;

  late bool value = FavMovieApi.favList
      .any((element) => element.id == widget.currentMovie.id);

  @override
  void initState() {
    super.initState();
    _recList = MovieApi.getRecommendations(widget.currentMovie.id!);
    _characterList = CharacterApi.getCharacter(widget.currentMovie.id!);
    _playerList = TrailerApi.getTrailer(widget.currentMovie.id!);
    _backdropList = ImageApi.getImages(widget.currentMovie.id!);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: cache kısmı yapılacak 
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 510,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
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
                  child: rateBarDetails(),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Photos",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .7,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  color: Colors.black,
                  child: FutureBuilder<List<Backdrop>>(
                    future: _backdropList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Backdrop> _bckdroplst = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _bckdroplst.length,
                          itemBuilder: (BuildContext context, int index) {
                            var currentPhoto = _bckdroplst[index];
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PageView.builder(
                                        controller:
                                            PageController(initialPage: index),
                                        pageSnapping: true,
                                        itemCount: _bckdroplst.length,
                                        itemBuilder: (context, index) {
                                          var currentPhoto1 =
                                              _bckdroplst[index];
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/original/' +
                                                  currentPhoto1.filePath
                                                      .toString(),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/' +
                                        currentPhoto.filePath.toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("data yok"),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Trailer",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .7,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<PlayerTrailer>>(
                    future: _playerList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<PlayerTrailer> _plyrList = snapshot.data!;

                        return PlayerFragman(
                            trailer: _plyrList.first,
                            cuurentMovie: widget.currentMovie);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const SizedBox(
                  height: 13,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Cast",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
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
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
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
                                        backgroundColor: Colors.white,
                                        backgroundImage: activeCast
                                                    .profilePath !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    activeCast.profilePath
                                                        .toString(),
                                              )
                                            : const CachedNetworkImageProvider(
                                                'http://cdn.onlinewebfonts.com/svg/img_568656.png'),
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
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Recommended",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
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
                          padding: const EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var currentFilm = _listem[index];
                            return recList(context, currentFilm);
                          },
                          itemCount: 10,
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Data Yok"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row rateBarDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
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
          // height: 100,
          color: Colors.black,
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.background2),
                ),
                onPressed: () {
                  // FAVORİ SAYFASI İÇİN ÇALIŞAN KISIM
                  setState(() {
                    if (value) {
                      const snackBar = SnackBar(
                        content: Text(
                          'Bu filmi zaten listenize eklediniz.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      FavMovieApi.getFavFilm(widget.currentMovie.id!);
                      value = true;
                    }
                  });
                  // FAVORİ SAYFASI İÇİN ÇALIŞAN KISIM
                },
                child: value == true
                    ? const Icon(
                        Icons.bookmark_added_outlined,
                        color: Colors.greenAccent,
                        size: 40.0,
                      )
                    : const Icon(
                        Icons.bookmark_add_outlined,
                        color: Colors.redAccent,
                        size: 40.0,
                      ),
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                "Favorite",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(6.0),
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
                  "Language :",
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
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              const Icon(
                Icons.date_range,
                color: Colors.white,
                size: 40.0,
              ),
              const Text(
                "Year :",
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

  SizedBox recList(BuildContext context, MovieModel currentFilm) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .40,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Constants.background2,
            ),
            height: 292,
            // color: Constants.background2,
            margin: const EdgeInsets.all(4.0),
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (detailsContext) => DetailsPage(currentFilm),
                      ),
                    );
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    // width: 150,
                    height: 220,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500" +
                            currentFilm.backdropPath.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    currentFilm.title.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
