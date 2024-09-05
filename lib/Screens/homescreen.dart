import 'package:flutter/material.dart';
import 'package:movies/UI/recomended.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';
import '../UI/Featured.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            FeaturedMovie(),
        const SizedBox(height: 15,),
        Stack(
          children: [
           buildNewReleasesContainer(),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
         const Recomended()
      ],
    );
  }

  buildNewReleasesContainer() {
    return Container(
        color: AppColors.MoviesContainerColor,
        padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                "New Releases",
                style: AppStyle.ListTitle,
              )),
              const SizedBox(height: 8), // Spacing between title and list
              buildMoviesList(),
            ],
          ),
        );
  }

  buildMoviesList() {
    return Container(
      height: 170,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [buildMoviePreview(), buildBookmark()],
              ),
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

  buildMoviePreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      height: 150,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: const DecorationImage(image: AssetImage("assets/images/deadpool.png"),fit: BoxFit.cover)),
    );
  }
}
