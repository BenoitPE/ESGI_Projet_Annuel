import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data.dart';
import 'ItemsPage.dart';

class wishlistPage extends StatefulWidget {
  @override
  _wishlistPage createState() => _wishlistPage();
}

Future<List<Data>> ReadJsonData(MediaType media) async {
  final jsonData = await rootBundle.rootBundle.loadString('jsonfile/data.json');
  final list = json.decode(jsonData) as List<dynamic>;
  var items = [];
  list.forEach((element) {
    if (media == MediaType.Movie && element['mediaType'] == "Movie") {
      items.add(element);
    } else if (media == MediaType.Serie && element['mediaType'] == "Serie") {
      items.add(element);
    } else if (media == MediaType.Book && element['mediaType'] == "Book") {
      items.add(element);
    } else if (media == MediaType.Anime && element['mediaType'] == "Anime") {
      items.add(element);
    } else if (media == MediaType.Tous) {
      items.add(element);
    }
  });

  return items.map((e) => Data.fromJson(e)).toList();
}

MediaType media = MediaType.Tous;

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
                                        media = MediaType.Tous;
                                      });
                                    },
                                    child: Text(
                                      "Tous",
                                      style: (media == MediaType.Tous)
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
                                        media = MediaType.Movie;
                                      });
                                    },
                                    child: Text(
                                      "Films",
                                      style: (media == MediaType.Movie)
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
                                        media = MediaType.Serie;
                                      });
                                    },
                                    child: Text(
                                      "Séries",
                                      style: (media == MediaType.Serie)
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
                                        media = MediaType.Anime;
                                      });
                                    },
                                    child: Text(
                                      "Animés",
                                      style: (media == MediaType.Anime)
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
                                        media = MediaType.Book;
                                      });
                                    },
                                    child: Text(
                                      "Livres",
                                      style: (media == MediaType.Book)
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ))),
                          ]))),
                  FutureBuilder(
                    future: ReadJsonData(media),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Text('error');
                      } else if (data.hasData) {
                        var items = data.data as List<Data>;
                        return Container(
                            height: 530,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: AlignedGridView.count(
                              itemCount: items.length,
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 8,
                              itemBuilder: (context, index) {
                                var categorieData = items;
                                return Container(
                                  height: 200,
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
                                                              items[index]
                                                                  .imageUrl)
                                                          : AssetImage(
                                                                  'image/NoImage.jpg')
                                                              as ImageProvider,
                                                      fit: BoxFit.cover,
                                                      child: InkWell(
                                                          onTap: () =>
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ItemsPage(
                                                                              item: items[index]
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
      child: Text('Collection',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
    );
  }
}
