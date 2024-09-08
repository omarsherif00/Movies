import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Data/Model/popular_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Utilties/app_style.dart';

class FeaturedMovie extends StatelessWidget {
   FeaturedMovie({super.key});
 bool isAdded=false;
  List<PopularResults> results=[];

  @override
  Widget build(BuildContext context) {
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
          return const Center(child: CircularProgressIndicator());
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
            onTap: () {}
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
                                "https://image.tmdb.org/t/p/w500${popularResults.backdropPath}"),
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
                            onTap: () {},
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

















  //   return Stack(
  //     children: [
  //       // Movie poster background
  //       Container(
  //         width: double.infinity,
  //         height: 300, // Adjust height as needed
  //         decoration: const BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage("assets/images/doracover.png"), // Replace with your image path
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //
  //       // Gradient overlay for better text readability
  //       Container(
  //         width: double.infinity,
  //         height: 300,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               Colors.transparent,
  //               Colors.black.withOpacity(0.6),
  //             ],
  //             begin: Alignment.topCenter,
  //             end: Alignment.bottomCenter,
  //           ),
  //         ),
  //       ),
  //
  //       // Play button in the center of the movie poster
  //       Center(
  //         child: CircleAvatar(
  //           radius: 30, // Adjust the size of the play button
  //           backgroundColor: Colors.white.withOpacity(0.7),
  //           child: Icon(
  //             Icons.play_arrow,
  //             size: 40,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //
  //       // Movie title and details at the bottom of the image
  //       Positioned(
  //         bottom: 20,
  //         left: 200,
  //
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Dora and the Lost City of Gold",
  //               style: AppStyle.FeaturedMovieTitle
  //               ),
  //             const SizedBox(height: 8), // Space between title and details
  //             Text(
  //               "2019  PG-13  2h 7m",
  //               style: AppStyle.FeaturedMovieDetailLine
  //             ),
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //           bottom: 0,
  //           left: 0,
  //           child: Container(height: 200,width: 200,decoration: BoxDecoration(image: DecorationImage(image:AssetImage("assets/images/dora.png"))),))
  //     ],
  //   );
  // }

}
