
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
import 'package:movies/Data/Model/popular_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Providers/list_provider.dart';
import 'package:movies/Screens/movie_details.dart';
import 'package:movies/UI/firebase.dart';
import 'package:movies/Utilties/app_style.dart';
import 'package:provider/provider.dart';

class FeaturedMovie extends StatefulWidget {
  FeaturedMovie({super.key});

  @override
  State<FeaturedMovie> createState() => _FeaturedMovieState();
}

class _FeaturedMovieState extends State<FeaturedMovie> {
  bool isAdded=false;

  List<PopularResults> results=[];

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: ApiManager.getPopular(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
              children: [
                Text(snapshot.error.toString()),
                ElevatedButton(onPressed: () {}, child: const Text("Retry"))]);
        } else if (snapshot.hasData) {
          return BuildSlider(height, width,snapshot.data!.results!);
        } else {
          return Expanded(flex: 3,child: const Center(child: CircularProgressIndicator()));
        }
      },
    );

    //List<Widget> result=results.map((PopularResults) => ).toList();


  }

  Widget BuildSlider(double height, double width,List<PopularResults> results) {
    return CarouselSlider.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final popularResults = results[itemIndex];
        return InkWell(
          onTap: () {
            MovieDetailsPage(context,results[itemIndex]);
          }
          ,
          child: Container(
            height: height,
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: height * 0.28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${ApiManager.BaseUrl}${popularResults.backdropPath}"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 175),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                                popularResults.title!,
                                style: AppStyle.FeaturedMovieTitle
                            ),
                          ),
                          Center(
                            child: Text(
                              popularResults.releaseDate!,
                              style: const TextStyle(
                                color: Color(0xffB5B4B4),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.12,
                  left: 20,
                  child: Container(
                    width: width * 0.35,
                    height: height * 0.24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500${popularResults.posterPath}",
                          ),
                          fit: BoxFit.cover,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {

                              isAdded=true;
                            });
                            FirebaseStorage.SetDataInStorage(
                                "${popularResults.id}",
                                "${popularResults.title}",
                                "${popularResults.releaseDate}",
                                "${popularResults.backdropPath}");
                            listProvider.getDataFromStorage();
                            listProvider.getDataFromStorage();
                          },
                          child: Image.asset(
                            isAdded
                                ? 'assets/images/bookmarkchecked.png'
                                : 'assets/images/bookmark.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: height * 0.38,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.linear,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        enlargeCenterPage: true,
        enlargeFactor: 0.20,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  MovieDetailsPage(BuildContext context,PopularResults popularResults) {
    List<int>? GenreList=popularResults.genreIds;
    Navigator.pushNamed(context, MovieDetails.routeName,
        arguments: MovieArguments(
            MovieId: "${popularResults.id}",
            genres: GenreList!.map((id) => id.toString()).toList()));
  }
}
