import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_api_app/model/character_model.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/services/character_api.dart';

class DetailsPage extends StatefulWidget {
  // DetailsPage({Key? key}) : super(key: key);
  final MovieModel currentMovie;
  CharacterModel? currentCharacter;
  /*String posterpath, title, overview, orj_lang;
  DateTime releaseDate;
  double vote;*/

  DetailsPage(this.currentMovie);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //Future<List<CharacterModel>>
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
                    widget.currentMovie.backdropPath.toString(),
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
                  child: Row(
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
                              widget.currentMovie.voteCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
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
                                "Language:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                widget.currentMovie.originalLanguage
                                    .toString()
                                    .toUpperCase(),
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
                              "Year:",
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
                      Container(), //Önerilen Listesi Eklenecek
                    ],
                  ),
                ),
                // Container(
                //     child: Center(
                //   child: FutureBuilder<List<CharacterModel>>(
                //     future:
                //         CharacterApi.getCharacter(widget.currentCharacter!.id!),
                //     builder: (context, snapshot) {},
                //   ),
                // ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
