import 'package:flutter/material.dart';
import 'package:movies/Data/Model/Upcoming_source.dart';
import 'package:movies/Data/Model/upcoming_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/UI/recomended.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';
import '../UI/Featured.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeaturedMovie(),
        const SizedBox(
          height: 15,
        ),

        ///check again for future`
        FutureBuilder(
          future: ApiManager.getUpComing(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error.toString()),
                  ElevatedButton(onPressed: () {}, child: Text("Retry"))
                ],
              );
            } else if (snapshot.hasData) {
              return buildNewReleasesStack(snapshot.data!.results!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
         Recomended()
      ],
    );
  }


  buildBookmark() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.bookmark_add),
      color: AppColors.BookMark,
      iconSize: 35,
    );
  }


  Stack buildNewReleasesStack(List<UpcomingResults> results) {
    return Stack(
      children: [
        buildNewReleasesContainer(results),
      ],
    );
  }

  buildNewReleasesContainer(List<UpcomingResults> results) {
    return Container(
      color: AppColors.MoviesContainerColor,
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "New Releases",
                style: AppStyle.ListTitle,
              )),
          const SizedBox(height: 8), // Spacing between title and list
          buildMoviesList(results),
        ],
      ),
    );
  }

  buildMoviesList(List<UpcomingResults> results) {
    List<Widget> UpcomingMovies = results
        .map((UpcomingResults) => buildContainer(UpcomingResults))
        .toList();
    return Container(
      height: 170,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [buildContainer(results[index]), buildBookmark()],
              ),
            ),
          );
        },
      ),
    );
  }





  Widget buildContainer(UpcomingResults UpcomingResults) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: 120,
    height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
                image: NetworkImage(
                    "${ApiManager.BaseUrl}${UpcomingResults.posterPath}"),fit: BoxFit.cover)),
      );


  //
  // buildMoviePreview() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 10),
  //     width: 120,
  //     height: 150,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8.0),
  //         image: const DecorationImage(
  //             image: AssetImage("assets/images/deadpool.png"),
  //             fit: BoxFit.cover)),
  //   );
  // }
}
