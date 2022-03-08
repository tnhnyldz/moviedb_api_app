import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../model/movie_model.dart';

class HorizontalWidget extends StatefulWidget {
  final MovieModel currentMovie;
  HorizontalWidget({Key? key, required this.currentMovie}) : super(key: key);

  @override
  State<HorizontalWidget> createState() => _HorizontalWidgetState();
}

class _HorizontalWidgetState extends State<HorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return horizontal(context, widget.currentMovie);
  }

  Widget horizontal(BuildContext context, MovieModel currentMovie) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .40,
      child: Column(
        children: [
          Container(
            height: 292,
            color: Colors.amber,
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.red,
                  width: 150,
                  height: 120,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500" +
                        currentMovie.backdropPath.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  currentMovie.title.toString(),
                  style: TextStyle(fontSize: 12),
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
                          (currentMovie.voteAverage!.toDouble() / 2) - 0.5,
                      itemSize: 18,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      /* onRatingUpdate: (rating) => setState(() {
                      this.rating = rating;
                    }), */
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Icon(Icons.star_border_outlined),
                    Text(
                        "Yayın Yılı: " +
                            DateFormat.yMMMd().format(DateTime.parse(
                                currentMovie.releaseDate.toString())),
                        /* currentMovie.releaseDate!.day.toString() +
                          ' - ' +
                          currentMovie.releaseDate!.month.toString() +
                          ' - ' +
                          currentMovie.releaseDate!.year.toString(), */
                        style: TextStyle(fontSize: 12)),
                    Text("Popülerlik: " + currentMovie.popularity.toString(),
                        style: TextStyle(fontSize: 12)),
                    Text(
                        "Puan: " +
                            (currentMovie.voteAverage!.toDouble() / 2)
                                .toStringAsFixed(1),
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.red),
                  onPressed: () {},
                  child: const Text('Detaylar', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
