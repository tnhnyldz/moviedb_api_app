import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb_api_app/model/movie_model.dart';
import 'package:moviedb_api_app/screens/Widgets/popularRow.dart';
import 'package:moviedb_api_app/screens/favoritepage/favorite_page.dart';
import 'package:moviedb_api_app/screens/profilepage/profile_page.dart';
import 'package:moviedb_api_app/services/moviedb_api.dart';

import '../Widgets/custom_app_bar.dart';
import '../detailspage/DetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MovieModel> _filmListFuture;
  late List<MovieModel> _filmListTopRated;
  late List<MovieModel> _filmListUpcoming;
  bool state = false;
  List<String> list = ['popular', 'top_rated', 'upcoming'];

  final _isLoading = true;
  int currentIndex = 0;

  final screens = [const HomePage(), FavoritePage(), ProfilePage()];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: state
          ? ListView(children: [
              const CustomAppBar(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // upcomıng tıtle
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upcoming',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      // Slider Container
                      Container(
                        height: 250,
                        color: Colors.black,
                        child: CarouselSlider.builder(
                          itemCount: 20,
                          itemBuilder:
                              (BuildContext context, int index, realindex) {
                            MovieModel currentMovie5 = _filmListUpcoming[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (detailsContext) =>
                                            DetailsPage(
                                              currentMovie5,
                                            )));
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${currentMovie5.backdropPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 15),
                                    child: Text(
                                      currentMovie5.title
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'roboto'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
                      // popular title
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        child: Text('Popular',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                letterSpacing: .7,
                                fontSize: 42,
                              ),
                            )),
                      ),
                      // popular row
                      SizedBox(
                        height: 300,
                        child: Scrollbar(
                          showTrackOnHover: true,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _filmListFuture.length,
                              itemBuilder: ((context, index) {
                                MovieModel currentMovie =
                                    _filmListFuture[index];

                                return HorizontalWidget(
                                    currentMovie: currentMovie);
                              })),
                        ),
                      ),
                      // top rated title
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Top Rated',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 42,
                            ),
                          ),
                        ),
                      ),
                      // Toprated row
                      Scrollbar(
                        showTrackOnHover: true,
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _filmListTopRated.length,
                            itemBuilder: ((context, index) {
                              MovieModel currentModel2 =
                                  _filmListTopRated[index];
                              return HorizontalWidget(
                                  currentMovie: currentModel2);
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
                semanticsLabel: 'Linear progress indicator',
              ),
              // child: Skeleton(
              //   shimmerGradient: const LinearGradient(
              //     colors: [
              //       Color.fromARGB(255, 67, 72, 75),
              //       Color.fromARGB(255, 173, 178, 181),
              //       Color.fromARGB(255, 67, 72, 75),
              //     ],
              //     stops: [
              //       0.1,
              //       0.5,
              //       0.9,
              //     ],
              //   ),
              //   isLoading: _isLoading,
              //   skeleton: SkeletonItem(
              //     child: Container(
              //       alignment: Alignment.centerLeft,
              //       margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              //       child: Column(
              //         // mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Container(
              //             alignment: Alignment.centerLeft,
              //             child: SkeletonAvatar(
              //               style: SkeletonAvatarStyle(
              //                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
              //                   borderRadius: BorderRadius.circular(35),
              //                   shape: BoxShape.rectangle,
              //                   width: 180,
              //                   height: 50),
              //             ),
              //           ),
              //           Row(
              //             children: [
              //               SkeletonAvatar(
              //                 style: SkeletonAvatarStyle(
              //                     borderRadius: BorderRadius.circular(35),
              //                     padding:
              //                         const EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                     shape: BoxShape.rectangle,
              //                     width: 160,
              //                     height: 320),
              //               ),
              //               SkeletonAvatar(
              //                 style: SkeletonAvatarStyle(
              //                     borderRadius: BorderRadius.circular(35),
              //                     padding:
              //                         const EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                     shape: BoxShape.rectangle,
              //                     width: 160,
              //                     height: 320),
              //               ),
              //               const Expanded(
              //                 child: SkeletonAvatar(
              //                   style: SkeletonAvatarStyle(
              //                     borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(35),
              //                         bottomLeft: Radius.circular(35)),
              //                     padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                     shape: BoxShape.rectangle,
              //                     // width: 60,
              //                     height: 320,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Container(
              //             alignment: Alignment.centerLeft,
              //             child: SkeletonAvatar(
              //               style: SkeletonAvatarStyle(
              //                   borderRadius: BorderRadius.circular(35),
              //                   padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
              //                   shape: BoxShape.rectangle,
              //                   width: 180,
              //                   height: 50),
              //             ),
              //           ),
              //           Expanded(
              //             child: Row(
              //               children: const [
              //                 SkeletonAvatar(
              //                   style: SkeletonAvatarStyle(
              //                       borderRadius: BorderRadius.only(
              //                           topLeft: Radius.circular(35),
              //                           topRight: Radius.circular(35)),
              //                       padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                       shape: BoxShape.rectangle,
              //                       width: 160,
              //                       height: 500),
              //                 ),
              //                 SkeletonAvatar(
              //                   style: SkeletonAvatarStyle(
              //                       borderRadius: BorderRadius.only(
              //                           topLeft: Radius.circular(35),
              //                           topRight: Radius.circular(35)),
              //                       padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                       shape: BoxShape.rectangle,
              //                       width: 160,
              //                       height: 500),
              //                 ),
              //                 Expanded(
              //                   child: SkeletonAvatar(
              //                     style: SkeletonAvatarStyle(
              //                       borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(35),
              //                       ),
              //                       padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              //                       shape: BoxShape.rectangle,
              //                       // width: 60,
              //                       height: 500,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              //   child: const HomePage(),
              // ),
            ),
    );
  }
}
