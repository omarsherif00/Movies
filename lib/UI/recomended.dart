import 'package:flutter/material.dart';
import 'package:movies/Data/Model/Toprated_source.dart';
import 'package:movies/Data/Model/toprated_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';

class Recomended extends StatelessWidget {
   Recomended({super.key});
late String MovieRating;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getTopRated(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
              children: [
                Text(snapshot.error.toString()),
                ElevatedButton(onPressed: () {}, child: const Text("Retry"))]);
        } else if (snapshot.hasData) {
          return buildNewRecomendedContainer(snapshot.data!.results!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  buildNewRecomendedContainer(List<TopRatedResults> results) {
    return Container(
      color: AppColors.MoviesContainerColor,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Recomended",
                style: AppStyle.ListTitle,
              )),
          const SizedBox(height: 8), // Spacing between title and list
          buildMoviesList(results),
        ],
      ),
    );
  }

  buildMoviesList(List<TopRatedResults> results) {
    List<Widget> recomended_results=results.map((result) => buildMoviePreview(result)).toList();
    return Container(
      height: 200,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: recomended_results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [buildMoviePreview(results[index]), buildBookmark()],
              ),
            ),
          );
        },
      ),
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

 Widget buildMoviePreview(TopRatedResults ratedResults) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 120,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image:  DecorationImage(
                      image: NetworkImage("${ApiManager.BaseUrl}${ratedResults.posterPath}"),
                      fit: BoxFit.cover)),
            ),
            Container(color: AppColors.RatingsContainer,
              child: Column(
                children: [
                  Container(color: AppColors.RatingsContainer,
                    child: Row(children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      SizedBox(width: 5),
                      Text(
                        "${ratedResults.voteAverage}",
                        style: AppStyle.FeaturedMovieDetailLine,
                      ), SizedBox(width: 70)
                    ]),

                  ),
                  SizedBox(height: 2,),
                  Container(color: AppColors.RatingsContainer,
                    child: Row(children: [
                      Text(
                        "${ratedResults.title}",
                        style: AppStyle.FeaturedMovieDetailLine,
                      ), SizedBox(width: 60)
                    ]),
                  ),
                  SizedBox(height: 2,),
                  Container(color: AppColors.RatingsContainer,
                    child: Row(children: [
                      Text(
                        "${ratedResults.releaseDate}",
                        style: AppStyle.FeaturedMovieDetailLine,
                      ),

                      SizedBox(width: 35)
                    ]),
                  ),
                  SizedBox(height: 2,)
                ],
              ),
            )
          ],
        )

      ],
    );
  }
}
