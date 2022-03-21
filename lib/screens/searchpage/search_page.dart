import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';
import 'package:moviedb_api_app/screens/detailspage/DetailsPage.dart';
import 'package:moviedb_api_app/services/search_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<MovieModel>> _searchList;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    _searchList = SearchApi.getSearchedFilms('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const CustomAppBar(),
        Container(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (deger) {
                        setState(() {
                          _searchList = SearchApi.getSearchedFilms(deger);
                        });
                      },
                      //controller: searchController,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.amber,
                          ),
                          filled: true,
                          fillColor: Colors.white60,
                          hintText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<MovieModel>>(
            future: _searchList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MovieModel> _srcList = snapshot.data!;
                ScrollController controller = ScrollController();
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var activeSearch = _srcList[index];
                    if (activeSearch.title == null) {
                      if (index < 19) {
                        index++;
                        activeSearch = _srcList[index];
                      }

                      return Container();
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (detailsContext) =>
                                          DetailsPage(activeSearch),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: activeSearch.backdropPath !=
                                          null
                                      ? CachedNetworkImageProvider(
                                          'https://image.tmdb.org/t/p/w500' +
                                              activeSearch.backdropPath
                                                  .toString(),
                                        )
                                      : const CachedNetworkImageProvider(
                                          'http://cdn.onlinewebfonts.com/svg/img_568656.png'),
                                ),
                                title: Text(activeSearch.title.toString())),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _srcList.length,
                );
              } else {
                return const Center(
                    child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ));
              }
            },
          ),
        )
      ]),
    );
  }
}
