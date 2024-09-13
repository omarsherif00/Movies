import 'package:flutter/material.dart';
import 'package:movies/Utilties/app_colors.dart';

class AppTheme {
  static ThemeData LightTheme = ThemeData(
      canvasColor: AppColors.PrimaryColorBlack,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.SecondryColor,
          unselectedItemColor: AppColors.Icon_TextColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 50
      ),
      scaffoldBackgroundColor: AppColors.BgColor,

  );

}
