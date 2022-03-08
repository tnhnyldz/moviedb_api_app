import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/Widgets/popularRow.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MovieModel> _filmListFuture;
  late List<MovieModel> _filmListTopRated;
  bool state = false;
  List<String> list = ['popular', 'top_rated'];

  void getApi() async {
    _filmListFuture = await MovieApi.getFilms(list[0]);
    _filmListTopRated = await MovieApi.getFilms(list[1]);
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
      appBar: AppBar(
        title: Text("Movie APP"),
      ),
      body: state
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListTopRated.length,
                          itemBuilder: ((context, index) {
                            MovieModel currentModel2 = _filmListTopRated[index];
                            return HorizontalWidget(currentMovie: currentModel2);
                          })),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListFuture.length,
                          itemBuilder: ((context, index) {
                            return Text("aa");
                          })),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filmListFuture.length,
                          itemBuilder: ((context, index) {
                            return Text("aa");
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
