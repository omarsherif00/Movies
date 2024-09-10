import 'package:flutter/material.dart';
import 'package:movies/Data/Model/Movie_detail_source.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
import 'package:movies/Data/Model/movie_genres.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key});

  late MovieArguments args;

  static const String routeName = "movieDetails";

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as MovieArguments;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ApiManager.movie_id = args.MovieId;
    return FutureBuilder(
      future: ApiManager.getMovieDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(snapshot.error.toString()),
              ElevatedButton(onPressed: () {}, child: Text("Retry"))
            ],
          );
        } else if (snapshot.hasData) {
          return MovieWidget(width, height, context, snapshot.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Scaffold MovieWidget(double width, double height, BuildContext context,
      MovieDetailSource movieDetailSource) {
    // List<Widget> GenreWidget = movieDetailSource.genres!
    //     .map(
    //       (genre) => Genrecontainer(genre?.name ?? ""),
    // )
    //     .toList();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${movieDetailSource.title}",
            style: AppStyle.MovieDetailsAppBar,
          ),
          backgroundColor: AppColors.AppBarColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${ApiManager.BaseUrl}${movieDetailSource.backdropPath}"),
                    fit: BoxFit.cover)),
            // width: width,
            height: height * 0.24,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${movieDetailSource.title}",
                  style: AppStyle.MovieDetailsTitle,
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${movieDetailSource.releaseDate}",
                    style: AppStyle.FeaturedMovieDetailLine),
              ),
              SizedBox(
                height: height * 0.25,
                //width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Container(
                      width: width * 0.30,
                      height: height * 0.45,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiManager.BaseUrl}${movieDetailSource.posterPath}"),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [SizedBox(
                          //width: 80,
                          height: MediaQuery.of(context).size.height*0.03,
                          child: ListView.builder(scrollDirection: Axis.horizontal,
                          itemCount: movieDetailSource.genres!.length,
                              itemBuilder: (context, index) {
                            return Genrecontainer(movieDetailSource.genres?[index].name?? "");
                          },
                          ),
                        ),
                          Text(
                            "${movieDetailSource.overview}",
                            style: AppStyle.MovieDetailsDescreption.copyWith(
                                color: AppColors.Icon_TextColor),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: width,
            child: buildNewRecomendedContainer(context),
          )
        ]),
      ),
    );
  }

  Container Genrecontainer(String genrename) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.Icon_TextColor)),
            child: Text(genrename,
                style: AppStyle.MovieDetailsDescreption.copyWith(
                    color: AppColors.Icon_TextColor)));
  }

  buildNewRecomendedContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.MoviesContainerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More Like This",
            style: AppStyle.ListTitle,
          ),
          const SizedBox(height: 8), // Spacing between title and list
          buildMoviesList(context),
        ],
      ),
    );
  }

  buildMoviesList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Stack(
              alignment: Alignment.topLeft,
              children: [buildMoviePreview(), buildBookmark()],
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

  Widget buildMoviePreview() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/dora.png"),
                    fit: BoxFit.cover)),
          ),
        ),
        Container(
          width: 120,
          color: AppColors.RatingsContainer,
          child: Column(
            children: [
              Container(
                color: AppColors.RatingsContainer,
                child: Row(children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "rate",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                color: AppColors.RatingsContainer,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "title",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                color: AppColors.RatingsContainer,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "2020",
                      style: AppStyle.FeaturedMovieDetailLine,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 2,
              )
            ],
          ),
        )
      ],
    );
  }
}
