import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Data/movie_dm.dart';

class ListProvider extends ChangeNotifier{

   List<MovieDm> movielist=[];

   getDataFromStorage() async{
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
    QuerySnapshot querySnapshot=await collectionReference .get();
    List<QueryDocumentSnapshot> documents=querySnapshot.docs;
    movielist=documents.map((doc) {
      Map <String,dynamic> json=doc.data() as Map<String,dynamic>;
      return MovieDm.fromjson(json);
    }
    ).toList();
    notifyListeners();
    print(movielist);
  }
   bool isMovieInWatchlist(String id) {
     return movielist.any((movie) => movie.movie_id == id);
   }
}