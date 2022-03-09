import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:moviedb_api_app/constants/consts.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/Widgets/popularRow.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MovieModel> _filmListFuture;
  late List<MovieModel> _filmListTopRated;
  late List<MovieModel> _filmListUpcoming;
  bool state = false;
  List<String> list = ['popular', 'top_rated', 'upcoming'];

  void getApi() async {
    _filmListFuture = await MovieApi.getFilms(list[0]);
    _filmListTopRated = await MovieApi.getFilms(list[1]);
    _filmListUpcoming = await MovieApi.getFilms(list[2]);
    state = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcome"),
      // ),
      body: state
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Popular',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 42,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListFuture.length,
                          itemBuilder: ((context, index) {
                            MovieModel currentMovie = _filmListFuture[index];
                            return HorizontalWidget(currentMovie: currentMovie);
                          })),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Top Rated',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 42,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListTopRated.length,
                          itemBuilder: ((context, index) {
                            MovieModel currentModel2 = _filmListTopRated[index];
                            return HorizontalWidget(
                                currentMovie: currentModel2);
                          })),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Upcoming',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 42,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListFuture.length,
                          itemBuilder: ((context, index) {
                            MovieModel currentModel3 = _filmListTopRated[index];
                            return HorizontalWidget(
                                currentMovie: currentModel3);
                          })),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
