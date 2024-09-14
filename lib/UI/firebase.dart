import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/Data/movie_dm.dart';

class FirebaseStorage{

  // static List<MovieDm> movielist=[];


  static SetDataInStorage(String id,String title,String date, String imagepath){
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
    DocumentReference documentReference=collectionReference.doc(id);
    MovieDm movieDm=MovieDm(title: title,movie_id: id, doc_id: id,date: date,imagepath: imagepath);
    documentReference.set(movieDm.tojson());

  }

  static DeleteData(MovieDm movieDm){
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
    collectionReference.doc(movieDm.doc_id).delete().then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));

  }
  static Future<bool> isMovieInWishlist(String id) async {
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
    var doc = await collectionReference.doc(id).get();
    return doc.exists;
  }

  // static getDataFromStorage() async{
  //   CollectionReference collectionReference=FirebaseFirestore.instance.collection(MovieDm.collectionName);
  //   QuerySnapshot querySnapshot=await collectionReference .get();
  //   List<QueryDocumentSnapshot> documents=querySnapshot.docs;
  //   movielist=documents.map((doc) {
  //     Map <String,dynamic> json=doc.data() as Map<String,dynamic>;
  //     return MovieDm.fromjson(json);
  //   }
  //   ).toList();
  //   print(movielist);
  // }

}