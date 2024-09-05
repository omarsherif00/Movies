import 'package:flutter/material.dart';
import 'package:movies/Utilties/app_style.dart';

class FeaturedMovie extends StatelessWidget {
  const FeaturedMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Movie poster background
        Container(
          width: double.infinity,
          height: 300, // Adjust height as needed
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/doracover.png"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient overlay for better text readability
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Play button in the center of the movie poster
        Center(
          child: CircleAvatar(
            radius: 30, // Adjust the size of the play button
            backgroundColor: Colors.white.withOpacity(0.7),
            child: Icon(
              Icons.play_arrow,
              size: 40,
              color: Colors.black,
            ),
          ),
        ),

        // Movie title and details at the bottom of the image
        Positioned(
          bottom: 20,
          left: 200,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Dora and the Lost City of Gold",
                style: AppStyle.FeaturedMovieTitle
                ),
              const SizedBox(height: 8), // Space between title and details
              Text(
                "2019  PG-13  2h 7m",
                style: AppStyle.FeaturedMovieDetailLine
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(height: 200,width: 200,decoration: BoxDecoration(image: DecorationImage(image:AssetImage("assets/images/dora.png"))),))
      ],
    );
  }

}
