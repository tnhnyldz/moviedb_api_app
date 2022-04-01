import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/model/trailer_player_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerFragman extends StatefulWidget {
  PlayerFragman({Key? key, required this.trailer, required this.cuurentMovie})
      : super(key: key);

  PlayerTrailer trailer;
  final MovieModel cuurentMovie;

  @override
  State<PlayerFragman> createState() => _PlayerFragmanState();
}

class _PlayerFragmanState extends State<PlayerFragman> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.trailer.key.toString(),
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
