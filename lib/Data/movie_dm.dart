class MovieDm{
  static String collectionName="storage";
 late String movie_id;
  late String doc_id;
  late String title;
  late String imagepath;
  late String date;

  MovieDm({required this.movie_id,required this.doc_id,required this.title,required this.date,required this.imagepath});

  MovieDm.fromjson(Map<String,dynamic> json){
    doc_id=json["DocId"];
    movie_id=json["MovieId"];
    title=json["title"];
    imagepath=json["imagepath"];
    date=json["date"];
  }

  Map<String,dynamic> tojson()=>{
    "DocId":doc_id,
    "MovieId":movie_id,
    "title":title,
    "imagepath":imagepath,
    "date":date,
  };

}