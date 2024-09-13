import 'package:flutter/material.dart';
import 'package:movies/Data/Model/category.dart';

class Browse extends StatelessWidget {
 // Category category;
   Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text("Browse Categories",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.left),
      ),
     Expanded(
       child: GridView.builder(
           itemCount: Category.categories.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount:2,
           crossAxisSpacing: 32,
           mainAxisSpacing: 46,
           childAspectRatio: 16/9
         ),
         itemBuilder:(context, index) {
           return InkWell(onTap: () {
             
           },
             child:BuildCategoryContainer(Category.categories[index]) );

         },

       ),
     )
    ],
    );
  }

  BuildCategoryContainer(Category category) {
  return Container(margin: EdgeInsets.all(8),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(category.ImagePath))),),
      Center(child: Text(category.Name,textAlign:TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),))
      ],
    ),
  );


  }
}
