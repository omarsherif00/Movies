import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/Data/Model/Upcoming_source.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
import 'package:movies/Data/Model/upcoming_results.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Data/movie_dm.dart';
import 'package:movies/Providers/list_provider.dart';
import 'package:movies/Screens/movie_details.dart';
import 'package:movies/UI/firebase.dart';
import 'package:movies/UI/recomended.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';
import 'package:provider/provider.dart';
import '../UI/Featured.dart';

class HomeScreen extends StatelessWidget {
  // List<MovieDm> movielist=[];
  HomeScreen({super.key});

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
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
              return buildNewReleasesStack(snapshot.data!.results!, context);
            } else {
              return Expanded(
                  flex: 3,
                  child: const Center(child: CircularProgressIndicator()));
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

  buildBookmark(UpcomingResults upcomingResults) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              FirebaseStorage.SetDataInStorage(
                  "${upcomingResults.id}",
                  "${upcomingResults.title}",
                  "${upcomingResults.releaseDate}",
                  "${upcomingResults.backdropPath}");
              listProvider.getDataFromStorage();
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 1),
              child: Image.asset(
                'assets/images/bookmark.png',
              ),
            ),
          ),
        ]);
  }

  Stack buildNewReleasesStack(
      List<UpcomingResults> results, BuildContext context) {
    return Stack(
      children: [
        buildNewReleasesContainer(results, context),
      ],
    );
  }

  buildNewReleasesContainer(
      List<UpcomingResults> results, BuildContext context) {
    return Container(
      color: AppColors.MoviesContainerColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Releases",
            style: AppStyle.ListTitle,
          ),
          const SizedBox(height: 8), // Spacing between title and list
          buildMoviesList(results, context),
        ],
      ),
    );
  }

  buildMoviesList(List<UpcomingResults> results, BuildContext context) {
    List<Widget> UpcomingMovies = results
        .map((UpcomingResults) => buildContainer(UpcomingResults))
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              MovieDetailsPage(context, results[index]);
              ApiManager.getMovieDetails();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  buildContainer(results[index]),
                  buildBookmark(results[index])
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildContainer(UpcomingResults UpcomingResults) => Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
                image: NetworkImage(
                    "${ApiManager.BaseUrl}${UpcomingResults.posterPath}"),
                fit: BoxFit.cover)),
      );

  MovieDetailsPage(BuildContext context, UpcomingResults upcomingResults) {
    List<int>? GenreList = upcomingResults.genreIds;
    Navigator.pushNamed(context, MovieDetails.routeName,
        arguments: MovieArguments(
            MovieId: "${upcomingResults.id}",
            genres: GenreList!.map((id) => id.toString()).toList()));
  }

  ///el id byt7at sa7
// SetDataInStorage(UpcomingResults upcomingResults){
//   CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
//   DocumentReference documentReference=collectionReference.doc();
//   MovieDm movieDm=MovieDm(movie_id: "${upcomingResults.id}", doc_id: documentReference.id);
//   documentReference.set(movieDm.tojson());
//
// }
//
// getDataFromStorage() async{
//   CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
//   QuerySnapshot querySnapshot=await collectionReference .get();
//   List<QueryDocumentSnapshot> documents=querySnapshot.docs;
//   movielist=documents.map((doc) {
//     Map <String,dynamic> json=doc.data() as Map<String,dynamic>;
//     return MovieDm.fromjson(json);
//   }
//   ).toList();
//   print(movielist);
// }
}
