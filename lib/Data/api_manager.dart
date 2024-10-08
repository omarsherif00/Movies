import 'dart:convert';
import 'package:movies/Data/Model/Morelikethis_source.dart';
import 'package:movies/Data/Model/Movie_detail_source.dart';
import 'package:movies/Data/Model/Search_source.dart';
import 'package:movies/Data/Model/Toprated_source.dart';
import 'package:movies/Data/Model/movie_list.dart';
import 'package:movies/Data/Model/popular_source.dart';
import 'package:movies/Data/Model/upcoming_source.dart';
import 'package:http/http.dart';

abstract class ApiManager {
  static String Apikey = "7e2558ee68ff957f7f0a6ddf06234a5a";
  static String BaseUrl = "https://image.tmdb.org/t/p/w500";
  static String movie_id = "2";
  static String Query = "";

  static Future<UpcomingSource> getUpComing() async {
    Response UpcomingResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$Apikey'));

    if (UpcomingResponse.statusCode >= 200 &&
        UpcomingResponse.statusCode < 300) {
      Map json = jsonDecode(UpcomingResponse.body) as Map;
      UpcomingSource response = UpcomingSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<TopRatedSource> getTopRated() async {
    Response TopRatedResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$Apikey'));

    if (TopRatedResponse.statusCode >= 200 &&
        TopRatedResponse.statusCode < 300) {
      Map json = jsonDecode(TopRatedResponse.body) as Map;
      TopRatedSource response = TopRatedSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<PopularSource> getPopular() async {
    Response PopularResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$Apikey'));

    if (PopularResponse.statusCode >= 200 && PopularResponse.statusCode < 300) {
      Map json = jsonDecode(PopularResponse.body) as Map;
      PopularSource response = PopularSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<MovieDetailSource> getMovieDetails() async {
    Response MovieDetailsResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movie_id?api_key=$Apikey'));

    if (MovieDetailsResponse.statusCode >= 200 &&
        MovieDetailsResponse.statusCode < 300) {
      Map json = jsonDecode(MovieDetailsResponse.body) as Map;
      MovieDetailSource response = MovieDetailSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<MoreLikeThisSource> getMoreLikeThis() async {
    Response MoreLikeThisResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movie_id/similar?api_key=$Apikey'));

    if (MoreLikeThisResponse.statusCode >= 200 &&
        MoreLikeThisResponse.statusCode < 300) {
      Map json = jsonDecode(MoreLikeThisResponse.body) as Map;
      MoreLikeThisSource response = MoreLikeThisSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<SearchSource> getSearchResult(String q) async {
    Response SearchResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${Apikey}&query=${q}'));

    if (SearchResponse.statusCode >= 200 && SearchResponse.statusCode < 300) {
      Map json = jsonDecode(SearchResponse.body) as Map;
      SearchSource response = SearchSource.fromJson(json);
      return response;
    } else {
      throw "something went wrong";
    }
  }

  static Future<MovieListSource> getMovieByCategory(String genreId) async {
    Response moviesListResponse = await get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Apikey}&with_genres=${genreId}'));

    if (moviesListResponse.statusCode >= 200 && moviesListResponse.statusCode < 300) {
      Map json = jsonDecode(moviesListResponse.body) as Map;
      MovieListSource response = MovieListSource.fromJson(json);
      print(genreId);
      return response;
    } else {
      throw "something went wrong";
    }
  }
}
