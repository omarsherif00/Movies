import 'package:http/http.dart';

class Category{
  String Id;
  String Name;
  String ImagePath;
  Category({required this.Id,required this.ImagePath,required this.Name});

  static List<Category> categories=[
  Category(Id: "28", ImagePath: "assets/images/action.jpg", Name: "Action"),
  Category(Id: "12", ImagePath: "assets/images/adventure.jpg", Name: "Adventure"),
  Category(Id: "16", ImagePath: "assets/images/animation.jpg", Name: "Animation"),
  Category(Id: "35", ImagePath: "assets/images/comedy.jpg", Name: "Comedy"),
  Category(Id: "80", ImagePath: "assets/images/Crime.jpg", Name: "Crime"),
  Category(Id: "27", ImagePath: "assets/images/horror.jpg", Name: "Horror"),
  Category(Id: "18", ImagePath: "assets/images/drama.jpg", Name: "Drama"),
  Category(Id: "10751", ImagePath: "assets/images/family.jpg", Name: "Family"),
  Category(Id:"14", ImagePath: "assets/images/fantasy.jpg", Name: "Fantasy"),
  Category(Id: "10752", ImagePath: "assets/images/war.jpg", Name: "War"),
  Category(Id: "53", ImagePath: "assets/images/thriller.jpg", Name: "Thriller"),
  Category(Id: "10749", ImagePath: "assets/images/romance.jpg", Name: "Romance"),
];
}