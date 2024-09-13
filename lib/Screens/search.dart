  import 'package:flutter/material.dart';
  import 'package:movies/Data/Model/Search_source.dart';
import 'package:movies/Data/Model/movie_arguments.dart';
  import 'package:movies/Data/Model/search_results.dart';
  import 'package:movies/Data/api_manager.dart';
import 'package:movies/Screens/movie_details.dart';
  import 'package:movies/Utilties/app_colors.dart';
  import 'package:movies/Utilties/app_style.dart';

  class Search extends StatefulWidget {
    Search({super.key});

    @override
    State<Search> createState() => _SearchState();
  }

  class _SearchState extends State<Search> {
    TextEditingController _searchController = TextEditingController();
  SearchSource? searchSource;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: buildAppBar(),
        body: searchSource==null || searchSource!.results==null || searchSource!.results!.isEmpty?
               Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_movies, size: 90,color: Colors.white),
                      Text("No Movies Found", style: AppStyle.ListTitle,
                        textAlign: TextAlign.center,)
                    ],
                  )): BuildListView(searchSource!, context)
      );}

    AppBar buildAppBar() {
      return AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: AppColors.BgColor,
          title: TextField(
            style: TextStyle(color: Colors.white, fontSize: 16),
            controller: _searchController,
            onChanged: (query) {
              LoadSearchResults(query);
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(24)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(24)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.white)),
              hintText: "Search",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
              hintStyle: TextStyle(fontSize: 14, color: AppColors.Icon_TextColor),
              filled: true,
              fillColor: AppColors.MoviesContainerColor,
            ),
          ));
    }

    LoadSearchResults(String q) async {

        //ApiManager.Query = q;
      final  result=await ApiManager.getSearchResult(q);
      print(result);
        setState(() {searchSource=result; });
    }

    BuildMovieContainer(BuildContext context,SearchResults searchResults) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .33,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .09,
                decoration: BoxDecoration(image: DecorationImage(
                    image: NetworkImage("${ApiManager.BaseUrl}${searchResults.backdropPath}"))),
              ),SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("${searchResults.title}",style: TextStyle(color: Colors.white,fontSize: 14),overflow: TextOverflow.ellipsis,),
                  Text("${searchResults.releaseDate}",style: TextStyle(color: AppColors.Icon_TextColor,fontSize: 12)),
                ],),
              )
            ],
          ),
          Divider(color: Color(0xff707070), thickness: 1, indent: 3, endIndent: 3,)
        ],
      );
    }

    BuildListView(SearchSource searchSource,BuildContext context) {
     return ListView.builder(
          itemCount:searchSource.results!.length,
          itemBuilder:(context, index) {
            return InkWell(
              onTap: () {
                MovieDetailsPage(context,searchSource.results![index]);
            },
              child: BuildMovieContainer(context,searchSource.results![index]),
            );
          }
      );
    }

  }
  MovieDetailsPage(BuildContext context,SearchResults searchResults) {
    List<int>? GenreList=searchResults.genreIds;
    Navigator.pushNamed(context, MovieDetails.routeName,
        arguments: MovieArguments(
            MovieId: "${searchResults.id}",
            genres: GenreList!.map((id) => id.toString()).toList()));
  }