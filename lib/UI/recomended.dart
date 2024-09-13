import 'package:flutter/material.dart';
import 'package:movies/Data/Model/Toprated_source.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
import 'package:movies/Data/Model/toprated_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Screens/movie_details.dart';
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
          return buildNewRecomendedContainer(snapshot.data!.results!,context);
        } else {
          return Expanded(flex: 3,child: const Center(child: CircularProgressIndicator()));
        }
      },
    );

  }

  buildNewRecomendedContainer(List<TopRatedResults> results,BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.24,
      color: AppColors.MoviesContainerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended",
            style: AppStyle.ListTitle,
          ),
          const SizedBox(height: 8), // Spacing between title and list
          buildMoviesList(results,context),
        ],
      ),
    );
  }



  buildMoviesList(List<TopRatedResults> results,BuildContext context) {
    List<Widget> recomended_results=results.map((result) => buildMoviePreview(result)).toList();
    return Container(
      height: MediaQuery.of(context).size.height*0.20,
      width: MediaQuery.of(context).size.width,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: recomended_results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              MovieDetailsPage(context,results[index]);
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [buildMoviePreview(results[index]), buildBookmark()],
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 120,
          height: 130,
          decoration: BoxDecoration(
              image:  DecorationImage(
                  image: NetworkImage("${ApiManager.BaseUrl}${ratedResults.posterPath}"),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: 120,
          color: AppColors.RatingsContainer,
          child: Column(
            children: [
              Container(color: AppColors.RatingsContainer,
                child: Row(children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "${ratedResults.voteAverage}",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),
                ]),

              ),
              SizedBox(height: 2,),
              Container(color: AppColors.RatingsContainer,
                child: Row(children: [
                  Expanded(
                    child: Text(overflow: TextOverflow.ellipsis,
                      "${ratedResults.title}",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 2,),
              Container(color: AppColors.RatingsContainer,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "${ratedResults.releaseDate}",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),


                ]),
              ),
              SizedBox(height: 2,)
            ],
          ),
        )
      ],
    );
  }


   MovieDetailsPage(BuildContext context,TopRatedResults ratedResults) {
     List<int>? GenreList=ratedResults.genreIds;
     Navigator.pushNamed(context, MovieDetails.routeName,
         arguments: MovieArguments(
             MovieId: "${ratedResults.id}",
             genres: GenreList!.map((id) => id.toString()).toList()));
   }
}
