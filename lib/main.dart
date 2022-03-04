import 'package:flutter/material.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MovieApi.getFilms();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movıe App'),
        ),
        body: Center(
          child: ListView(children: [
            const Text("Movıes"),
            Container(
              color: Colors.blue.shade200,
              width: 300,
              height: 300,
              child: horizontal1(),
            ),
            const Text("Tv Show"),
            Container(
              color: Colors.blue.shade200,
              width: 300,
              height: 300,
              child: horizontal1(),
            ),
            const Text("Trends"),
            Container(
              color: Colors.blue.shade200,
              width: 300,
              height: 300,
              child: horizontal1(),
            ),
          ]),
        ),
      ),
    );
  }

  ListView horizontal1() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
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
              ),
              Text("Film Adı"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border_outlined),
                  Text("Yayın Yılı: "),
                  Text("Popülerlik: "),
                  Text("Puan: "),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text('Detaylar'),
              ),
            ],
          ),
        ),
        Container(
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
              ),
              Text("Film Adı"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border_outlined),
                  Text("Yayın Yılı: "),
                  Text("Popülerlik: "),
                  Text("Puan: "),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text('Detaylar'),
              ),
            ],
          ),
        ),
        Container(
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
              ),
              Text("Film Adı"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border),
                  Text("Yayın Yılı: "),
                  Text("Popülerlik: "),
                  Text("Puan: "),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text('Detaylar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
