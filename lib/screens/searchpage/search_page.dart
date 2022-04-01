import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';
import 'package:moviedb_api_app/screens/detailspage/details_page.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                                borderSide: BorderSide.none),),
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
                  // ScrollController controller = ScrollController();
                  return ListView.builder(
                    // physics: const ClampingScrollPhysics(),
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
                      return Column(
                        children: [
                          ListView.separated(
                              padding: const EdgeInsets.all(20),
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (detailsContext) =>
                                              DetailsPage(
                                            activeSearch,
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child:
                                                  activeSearch.backdropPath !=
                                                          null
                                                      ? Image.network(
                                                          'https://image.tmdb.org/t/p/w200' +
                                                              activeSearch
                                                                  .backdropPath
                                                                  .toString(),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'assets/movie.png'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    activeSearch.title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                activeSearch.overview
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RatingBar.builder(
                                                    onRatingUpdate: (rating) =>
                                                        setState(() {
                                                      activeSearch.voteAverage =
                                                          rating;
                                                    }),
                                                    allowHalfRating: true,
                                                    unratedColor: Colors
                                                        .blueGrey.shade200,
                                                    itemCount: 5,
                                                    initialRating: (activeSearch
                                                                .voteAverage!
                                                                .toDouble() /
                                                            2) -
                                                        0.5,
                                                    itemSize: 18,
                                                    ignoreGestures: true,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Popularity : ' +
                                                    activeSearch.popularity
                                                        .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, index) => const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: 1)
                        ],
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
      ),
    );
  }
}
