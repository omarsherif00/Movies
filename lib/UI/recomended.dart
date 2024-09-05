import 'package:flutter/material.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:movies/Utilties/app_style.dart';

class Recomended extends StatelessWidget {
  const Recomended({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildNewReleasesContainer(),
      ],
    );
  }

  buildNewReleasesContainer() {
    return Container(
      color: AppColors.MoviesContainerColor,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Recomended",
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
      height: 200,
      color: AppColors.MoviesContainerColor,
      child: ListView.builder(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
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
    return Column(
      children: [
        Column(
        children: [
    Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: 120,
    height: 130,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    image: const DecorationImage(
    image: AssetImage("assets/images/pablo.png"),
    fit: BoxFit.cover)),
    ),
    Container(color: AppColors.RatingsContainer,
      child: Column(
        children: [
          Container(color: AppColors.RatingsContainer,
            child: Row(children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              SizedBox(width: 5),
              Text(
                "rating",
                style: AppStyle.FeaturedMovieDetailLine,
              ), SizedBox(width: 70)
            ]),

          ),
          SizedBox(height: 2,),
          Container(color: AppColors.RatingsContainer,
            child: Row(children: [
              Text(
                "movie name",
                style: AppStyle.FeaturedMovieDetailLine,
              ),SizedBox(width: 60)
            ]),
          ),
          SizedBox(height: 2,),
          Container(color: AppColors.RatingsContainer,
            child: Row(children: [
              Text(
                "date",
                style: AppStyle.FeaturedMovieDetailLine,
              ),
              SizedBox(width: 10),
              Text(
                "R",
                style: AppStyle.FeaturedMovieDetailLine,
              ),
              SizedBox(width: 10),
              Text(
                "duration",
                style: AppStyle.FeaturedMovieDetailLine,
              )
              ,SizedBox(width: 35)
            ]),
          ),
          SizedBox(height: 2,)
        ],
      ),
    )
      ],
    )

        ],
    );

  }
}
