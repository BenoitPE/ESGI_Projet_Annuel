import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_test/screens/searchPage.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data.dart';
import 'ItemsPage.dart';

class wishlistPage extends StatefulWidget {
  @override
  _wishlistPage createState() => _wishlistPage();
}

Future<List<Data>> ReadJsonData() async {
  final jsonData = await rootBundle.rootBundle.loadString('jsonfile/data.json');
  final list = json.decode(jsonData) as List<dynamic>;

  return list.map((e) => Data.fromJson(e)).toList();
}

bool film = false;
bool serie = false;
bool anime = false;
bool livre = false;
bool tous = true;

class _wishlistPage extends State<wishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(height: 60),
              textSection(),
              Container(
                child: Column(children: [
                  Container(
                      height: 90,
                      color: Colors.red,
                      child: AppBar(
                          backgroundColor: Colors.black,
                          automaticallyImplyLeading: false,
                          title: Row(children: <Widget>[
                            Container(
                                width: 72,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        film = false;
                                        serie = false;
                                        anime = false;
                                        livre = false;
                                        tous = true;
                                      });
                                    },
                                    child: Text(
                                      "Tous",
                                      style: (tous == true)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                            Container(
                                width: 72,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        film = true;
                                        serie = false;
                                        anime = false;
                                        livre = false;
                                        tous = false;
                                      });
                                    },
                                    child: Text(
                                      "Films",
                                      style: (film == true)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                            Container(
                                width: 72,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        film = false;
                                        serie = true;
                                        anime = false;
                                        livre = false;
                                        tous = false;
                                      });
                                    },
                                    child: Text(
                                      "Séries",
                                      style: (serie == true)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                            Container(
                                width: 72,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        film = false;
                                        serie = false;
                                        anime = true;
                                        livre = false;
                                        tous = false;
                                      });
                                    },
                                    child: Text(
                                      "Animés",
                                      style: (anime == true)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                            Container(
                                width: 72,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        film = false;
                                        serie = false;
                                        anime = false;
                                        livre = true;
                                        tous = false;
                                      });
                                    },
                                    child: Text(
                                      "Livres",
                                      style: (livre == true)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                          ]))),
                  FutureBuilder(
                    future: ReadJsonData(),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Text('error');
                      } else if (data.hasData) {
                        var items = data.data as List<Data>;
                        List<Data> nbMovie = [];
                        List<Data> nbSerie = [];
                        List<Data> nbBook = [];
                        List<Data> nbAnime = [];
                        items.forEach((element) {
                          if (element.movie != null) {
                            nbMovie.add(element);
                          } else if (element.serie != null) {
                            nbSerie.add(element);
                          } else if (element.book != null) {
                            nbBook.add(element);
                          } else if (element.anime != null) {
                            nbAnime.add(element);
                          }
                        });
                        return Container(
                            height: 530,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: AlignedGridView.count(
                              itemCount: (film == true)
                                  ? nbMovie.length
                                  : (serie == true)
                                      ? nbSerie.length
                                      : (anime == true)
                                          ? nbAnime.length
                                          : (livre == true)
                                              ? nbBook.length
                                              : items.length,
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 8,
                              itemBuilder: (context, index) {
                                var categorieData = (film == true)
                                    ? nbMovie
                                    : (serie == true)
                                        ? nbSerie
                                        : (anime == true)
                                            ? nbAnime
                                            : (livre == true)
                                                ? nbBook
                                                : items;
                                return Container(
                                  //width: 100,
                                  height: 200,
                                  //padding: EdgeInsets.fromLTRB(10, 10, 10, 10) ,
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Material(
                                                  child: Ink.image(
                                                      image: categorieData[
                                                                      index]
                                                                  .imageUrl !=
                                                              null
                                                          ? NetworkImage(
                                                              categorieData[
                                                                      index]
                                                                  .imageUrl)
                                                          : AssetImage(
                                                                  'image/NoImage.jpg')
                                                              as ImageProvider,
                                                      //  NetworkImage(
                                                      //     (categorieData[index].imageUrl != null ? categorieData[index].imageUrl : '' )),
                                                      fit: BoxFit.cover,
                                                      child: InkWell(
                                                          onTap: () =>
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ItemsPage(
                                                                              item: (categorieData[index].movie != null)
                                                                                  ? categorieData[index].movie
                                                                                  : (categorieData[index].serie != null)
                                                                                      ? categorieData[index].serie
                                                                                      : (categorieData[index].anime != null)
                                                                                          ? categorieData[index].anime
                                                                                          : categorieData[index].book,
                                                                            )),
                                                              )))))),
                                    ],
                                  ),
                                );
                              },
                            ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ]),
              )
            ]))));
  }
}

class textSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text('Liste de souhaits',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
    );
  }
}

// FutureBuilder(
//                     future: ReadJsonData(),
//                     builder: (context, data) {
//                       if (data.hasError) {
//                         return Text('error');
//                       } else if (data.hasData) {
//                         var items = data.data as List<Data>;
//                         List<Data> nbMovie = [];
//                         List<Data> nbSerie = [];
//                         List<Data> nbBook = [];
//                         List<Data> nbAnime = [];
//                         items.forEach((element) {
//                           if (element.movie.length != 0) {
//                             nbMovie.add(element);
//                           } else if (element.serie.length != 0) {
//                             nbSerie.add(element);
//                           } else if (element.book.length != 0) {
//                             nbBook.add(element);
//                           } else if (element.anime.length != 0) {
//                             nbAnime.add(element);
//                           }
//                         });
//                         return Container(
//                           height: 530,
//                           padding:
//                               EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                           //color: Colors.amber,
//                           child: GridView.builder(
//                             itemCount: (film == true)
//                                 ? nbMovie.length
//                                 : (serie == true)
//                                     ? nbSerie.length
//                                     : (anime == true)
//                                         ? nbAnime.length
//                                         : (livre == true)
//                                             ? nbBook.length
//                                             : items.length,
//                             itemBuilder: (context, index) {
//                               var categorieData = (film == true)
//                                   ? nbMovie
//                                   : (serie == true)
//                                       ? nbSerie
//                                       : (anime == true)
//                                           ? nbAnime
//                                           : (livre == true)
//                                               ? nbBook
//                                               : items;
//                               return Container(
//                                 //width: 100,
//                                 //height: 300,
//                                 //padding: EdgeInsets.fromLTRB(10, 10, 10, 10) ,
//                                 child: Column(
//                                   children: [
//                                     AspectRatio(
//                                         aspectRatio: 3 / 3,
//                                         child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                             child: Material(
//                                                 child: Ink.image(
//                                                     image: NetworkImage(
//                                                         categorieData[index]
//                                                             .imageUrl),
//                                                     fit: BoxFit.cover,
//                                                     child: InkWell(
//                                                         onTap: () =>
//                                                             Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) =>
//                                                                           ItemsPage(
//                                                                             item: (categorieData[index].movie.length != 0)
//                                                                                 ? categorieData[index].movie
//                                                                                 : (categorieData[index].serie.length != 0)
//                                                                                     ? categorieData[index].serie
//                                                                                     : (categorieData[index].anime.length != 0)
//                                                                                         ? categorieData[index].anime
//                                                                                         : categorieData[index].book,
//                                                                           )),
//                                                             )))))),
//                                   ],
//                                 ),
//                               );
//                             },
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 3,
//                                     crossAxisSpacing: 10,
//                                     mainAxisSpacing: 10),
//                           ),
//                         );
//                       } else {
//                         return CircularProgressIndicator();
//                       }
//                     },
//                   ),

// class itemSection extends StatelessWidget {
//   String name;

//   Future<List<Data>> ReadJsonData() async {
//     final jsonData =
//         await rootBundle.rootBundle.loadString('jsonfile/movie.json');
//     final list = json.decode(jsonData) as List<dynamic>;

//     return list.map((e) => Data.fromJson(e)).toList();
//   }

//   itemSection(this.name);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
//         Container(height: 90, color: Colors.red, child: ItemsAppBarWidget()),
//         FutureBuilder(
//           future: ReadJsonData(),
//           builder: (context, data) {
//             if (data.hasError) {
//               return Text('error');
//             } else if (data.hasData) {
//               var items = data.data as List<Data>;
//               return Container(
//                 height: 530,
//                 padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                 //color: Colors.amber,
//                 child: GridView.builder(
//                   itemCount: 30,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 100,
//                       //height: 140,
//                       child: Column(
//                         children: [
//                           Expanded(
//                               child: AspectRatio(
//                                   aspectRatio: 4 / 3,
//                                   child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(20),
//                                       child: Material(
//                                           child: Ink.image(
//                                               image: NetworkImage(
//                                                   items[index].imageUrl),
//                                               fit: BoxFit.cover,
//                                               child: InkWell(
//                                                   onTap: () => Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder:
//                                                                 (context) =>
//                                                                     ItemsPage(
//                                                                       item: items[
//                                                                           index],
//                                                                     )),
//                                                       ))))))),
//                         ],
//                       ),
//                     );
//                   },
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10),
//                 ),
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ]),
//     );
//   }

//   Widget buildCard({required CardItem item, required BuildContext context}) =>
//       Container(
//         width: 100,
//         //height: 140,
//         child: Column(
//           children: [
//             Expanded(
//                 child: AspectRatio(
//                     aspectRatio: 4 / 3,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Material(
//                             child: Ink.image(
//                                 image: NetworkImage(item.urlImage),
//                                 fit: BoxFit.cover))))),
//           ],
//         ),
//       );
// }

// class ItemsAppBarWidget extends StatefulWidget {
//   ItemsAppBar createState() => ItemsAppBar();
// }

// class ItemsAppBar extends State {
//   bool film = false;
//   bool serie = false;
//   bool anime = false;
//   bool livre = false;
//   bool tous = true;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         title: Row(children: <Widget>[
//           Container(
//               width: 72,
//               child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       film = false;
//                       serie = false;
//                       anime = false;
//                       livre = false;
//                       tous = true;
//                     });
//                   },
//                   child: Text(
//                     "Tous",
//                     style: (tous == true)
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.white.withOpacity(0.5)),
//                   ))),
//           Container(
//               width: 72,
//               child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       film = true;
//                       serie = false;
//                       anime = false;
//                       livre = false;
//                       tous = false;
//                     });
//                   },
//                   child: Text(
//                     "Films",
//                     style: (film == true)
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.white.withOpacity(0.5)),
//                   ))),
//           Container(
//               width: 72,
//               child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       film = false;
//                       serie = true;
//                       anime = false;
//                       livre = false;
//                       tous = false;
//                     });
//                   },
//                   child: Text(
//                     "Séries",
//                     style: (serie == true)
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.white.withOpacity(0.5)),
//                   ))),
//           Container(
//               width: 72,
//               child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       film = false;
//                       serie = false;
//                       anime = true;
//                       livre = false;
//                       tous = false;
//                     });
//                   },
//                   child: Text(
//                     "Animés",
//                     style: (anime == true)
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.white.withOpacity(0.5)),
//                   ))),
//           Container(
//               width: 72,
//               child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       film = false;
//                       serie = false;
//                       anime = false;
//                       livre = true;
//                       tous = false;
//                     });
//                   },
//                   child: Text(
//                     "Livres",
//                     style: (livre == true)
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.white.withOpacity(0.5)),
//                   ))),
//         ]));
//   }
// }
