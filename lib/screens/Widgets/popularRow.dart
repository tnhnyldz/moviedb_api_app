import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedb_api_app/constants/consts.dart';
import 'package:moviedb_api_app/screens/detailspage/DetailsPage.dart';

import '../../model/movie_model.dart';

class HorizontalWidget extends StatefulWidget {
  final MovieModel currentMovie;
  const HorizontalWidget({Key? key, required this.currentMovie})
      : super(key: key);

  @override
  State<HorizontalWidget> createState() => _HorizontalWidgetState();
}

class _HorizontalWidgetState extends State<HorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return horizontal(context, widget.currentMovie);
  }

  Widget horizontal(BuildContext context, MovieModel currentMovie) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (detailsContext) => DetailsPage(
              currentMovie,
            ),
          ),
        );
      },
      child: SizedBox(
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
                  SizedBox(
                    // color: Colors.red,
                    width: 150,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500" +
                            currentMovie.backdropPath.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      currentMovie.title.toString(),
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
                            (currentMovie.voteAverage!.toDouble() / 2) - 0.5,
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
      ),
    );
  }
}
