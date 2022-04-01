import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/movie.png"), fit: BoxFit.fitHeight),
          ),
        ),
      ],
    );
  }
}
