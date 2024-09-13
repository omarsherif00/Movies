import 'package:flutter/material.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Screens/movie_details.dart';
import 'package:movies/Screens/movie_list_screen.dart';
import 'package:movies/UI/home.dart';
import 'package:movies/Screens/splash_screen.dart';
import 'package:movies/Utilties/apptheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Home.routeName:(_)=>Home(),
        Splash.routeName:(_)=>Splash(),
        MovieDetails.routeName:(_)=>MovieDetails(),
        MovieListScreen.routeName:(_)=>MovieListScreen()
      },
      initialRoute: Splash.routeName,
    theme: AppTheme.LightTheme ,
    );

  }
}
