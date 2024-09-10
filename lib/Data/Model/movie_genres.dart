/// id : 35
/// name : "Comedy"

class MovieGenres {
  MovieGenres({
      this.id, 
      this.name,});

  MovieGenres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;
MovieGenres copyWith({  int? id,
  String? name,
}) => MovieGenres(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}