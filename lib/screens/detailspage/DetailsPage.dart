import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_api_app/model/movie_model.dart';

class DetailsPage extends StatefulWidget {
  // DetailsPage({Key? key}) : super(key: key);
  String posterpath, title, overview, orj_lang;
  DateTime releaseDate;
  double vote;

  DetailsPage(
    this.posterpath,
    this.title,
    this.overview,
    this.vote,
    this.orj_lang,
    this.releaseDate,
  );
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                "https://image.tmdb.org/t/p/w500" + widget.posterpath,
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
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    widget.title.toString(),
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
                  padding: EdgeInsets.all(10.0),
                  height: 160,
                  color: Colors.black,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.overview.toString(),
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
                              widget.vote.toString(),
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
                                widget.orj_lang.toString().toUpperCase(),
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
                                  widget.releaseDate.toString(),
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
