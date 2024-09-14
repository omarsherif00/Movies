import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Providers/list_provider.dart';
import 'package:movies/Screens/movie_details.dart';
import 'package:movies/Screens/movie_list_screen.dart';
import 'package:movies/UI/home.dart';
import 'package:movies/Screens/splash_screen.dart';
import 'package:movies/Utilties/apptheme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC7UhbJ50UfHJ9_pS4p1wEL5YvirWnEZ0A",
        appId: "1:316434420445:android:f6ddb6461cb9f8d6d18134",
        messagingSenderId: "",
        projectId: "movies-1fd19")
  );
  runApp(ChangeNotifierProvider(
      create: (_) => ListProvider(),
      child: const MyApp()));
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
