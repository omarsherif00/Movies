import 'dart:convert';
import 'package:movies/Data/Model/Toprated_source.dart';
import 'package:movies/Data/Model/popular_source.dart';
import 'package:movies/Data/Model/upcoming_source.dart';
import 'package:http/http.dart';

abstract class ApiManager {
  static String Apikey="7e2558ee68ff957f7f0a6ddf06234a5a";
  static String BaseUrl="https://image.tmdb.org/t/p/w500";

  static Future<UpcomingSource> getUpComing() async{
    Response UpcomingResponse= await get( Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$Apikey'));

        if(UpcomingResponse.statusCode>=200 && UpcomingResponse.statusCode<300){
          Map json=jsonDecode(UpcomingResponse.body) as Map;
         UpcomingSource response=UpcomingSource.fromJson(json);
         return response;
        }else{
           throw "something went wrong";
        }
  }
  static Future<TopRatedSource> getTopRated() async{
    Response TopRatedResponse= await get( Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$Apikey'));

        if(TopRatedResponse.statusCode>=200 && TopRatedResponse.statusCode<300){
          Map json=jsonDecode(TopRatedResponse.body) as Map;
         TopRatedSource response=TopRatedSource.fromJson(json);
         return response;
        }else{
           throw "something went wrong";
        }
  }

  static Future<PopularSource> getPopular() async{
    Response PopularResponse= await get( Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$Apikey'));

        if(PopularResponse.statusCode>=200 && PopularResponse.statusCode<300){
          Map json=jsonDecode(PopularResponse.body) as Map;
         PopularSource response=PopularSource.fromJson(json);
         return response;
        }else{
           throw "something went wrong";
        }
  }



  }


