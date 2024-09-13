import 'package:flutter/material.dart';
import 'package:movies/Data/Model/category.dart';
import 'package:movies/Screens/browse.dart';
import 'package:movies/Screens/homescreen.dart';
import 'package:movies/Screens/search.dart';
import 'package:movies/Screens/watchlist.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
List<Widget> Tabs=[HomeScreen(),Search(),Browse(),Watchlist()];

int SelectedIndex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          SelectedIndex=index;
          setState(() {});
        },
        currentIndex: SelectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 40), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 40), label: "search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie, size: 40), label: "browse"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book, size: 40), label: "watchlist"),
        ],
      ),
          body: Tabs[SelectedIndex],

    )
    );
  }
}
