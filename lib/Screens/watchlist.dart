import 'package:flutter/material.dart';
import 'package:movies/Data/api_manager.dart';
import 'package:movies/Data/movie_dm.dart';
import 'package:movies/Providers/list_provider.dart';
import 'package:movies/UI/firebase.dart';
import 'package:movies/Utilties/app_colors.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatefulWidget {
  //MovieDm movieDm;
  Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProvider.getDataFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Scaffold(appBar: buildAppBar(), body: BuildListView(context));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.BgColor,
      title: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text("WatchList",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.left),
      ),
    );
  }

  BuildMovieContainer(BuildContext context, MovieDm movieDm) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .33,
                  height: MediaQuery.of(context).size.height * .09,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "${ApiManager.BaseUrl}${movieDm.imagepath}"))),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${movieDm.title}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("${movieDm.date}",
                          style: TextStyle(
                              color: AppColors.Icon_TextColor, fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: Color(0xff707070),
              thickness: 1,
              indent: 3,
              endIndent: 3,
            )
          ],
        ),
    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    FirebaseStorage.DeleteData(movieDm);
                    listProvider.getDataFromStorage();
                    setState(() {
                    });
                  },
                  child: Image.asset(
                  'assets/images/bookmarkchecked.png',
                  ),
                ),
          ]),
      ],
    );
  }

  BuildListView(BuildContext context) {
    return ListView.builder(
        itemCount: listProvider.movielist.length,
        itemBuilder: (context, index) {
          return BuildMovieContainer(context, listProvider.movielist[index]);
        });
  }
}

