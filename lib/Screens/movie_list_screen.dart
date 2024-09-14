import 'package:flutter/material.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
import 'package:movies/Data/Model/movie_list.dart';
import 'package:movies/Data/Model/movie_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Screens/movie_details.dart';
import 'package:movies/Utilties/app_colors.dart';

class MovieListScreen extends StatelessWidget {
   MovieListScreen({super.key});
  static const String routeName="MovieListScreen";


  @override
  Widget build(BuildContext context) {
  final GenreId=ModalRoute.of(context)!.settings.arguments as String;
    return FutureBuilder(
      future: ApiManager.getMovieByCategory(GenreId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(snapshot.error.toString()),
              ElevatedButton(onPressed: () {}, child: const Text("Retry"))
            ],
          );
        } else if (snapshot.hasData) {
          return buildMovieList(snapshot.data!);
        } else {
          return Expanded(child: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

   buildMovieList(MovieListSource movieListSource) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.BgColor, title: const Padding(
        padding: EdgeInsets.only(bottom: 24.0,top: 24.0),
        child: Text("Movie List",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.left),
      ),) ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Expanded(
            child: GridView.builder(
              itemCount: movieListSource.results?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 46,
                  childAspectRatio: 16 / 9),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      MovieDetailsPage(context,movieListSource.results![index]);
                    }, child: BuildMovieByCategoryContainer(movieListSource.results![index]));
              },
            ),
          )
        ],
      ),
    );
  }

  BuildMovieByCategoryContainer(MovieResults movieResults) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${ApiManager.BaseUrl}${movieResults.backdropPath}"))),
          ),
          Center(
              child: Text(
            "${movieResults.title}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ))
        ],
      ),
    );
  }
   MovieDetailsPage(BuildContext context, MovieResults movieResults) {
     List<int>? GenreList=movieResults.genreIds;
     Navigator.pushNamed(context, MovieDetails.routeName,
         arguments: MovieArguments(
             MovieId: "${movieResults.id}",
             genres: GenreList!.map((id) => id.toString()).toList()));
   }
}
