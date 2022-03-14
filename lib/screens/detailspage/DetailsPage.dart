import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviedb_api_app/model/movie_model.dart';

class DetailsPage extends StatefulWidget {
  // DetailsPage({Key? key}) : super(key: key);
  String path, title;
  DetailsPage(this.path, this.title);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.amber,
          expandedHeight: 350,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.title.toString()),
            background: Image.network(
              // "https://source.unsplash.com/812jL3jmV1w",
              "https://image.tmdb.org/t/p/w500" + widget.path,
              scale: 1.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
