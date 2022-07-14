import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../models/data.dart';
import '../repository/data_repository.dart';
import 'ItemsPage.dart';

class collectionPage extends StatefulWidget {
  final user;
  const collectionPage({
    this.user,
  });
  @override
  _collectionPage createState() => _collectionPage(user);
}

Future<List<Data>> ReadJsonData(
    MediaType media, dynamic _dataRepository, dynamic user) async {
  var list;
  var list2;
  var items = [];
  List<Data> items2 = [];

  if (media == MediaType.Movie || media == MediaType.Tous) {
    final response =
        await http.get(Uri.parse('http://100.113.108.37:8081/getCollection?Id='+user.idUser.toString()));

    if (response.statusCode == 200) {
      list = json.decode(response.body) as List<dynamic>;
      log(response.reasonPhrase.toString());
      list.forEach((element) {
        items.add(element);

        //test cache
        _dataRepository.addData(Data.fromJson(element));
      });
    } else {
      log(response.statusCode.toString() +
          " : " +
          response.reasonPhrase.toString());
    }
  }

  // if (media == MediaType.Serie || media == MediaType.Tous) {
  //   final response2 =
  //       await http.get(Uri.parse('http://100.113.108.37/Serie/Popular'));

  //   if (response2.statusCode == 200) {
  //     list2 = json.decode(response2.body) as List<dynamic>;
  //     log(response2.reasonPhrase.toString());
  //     list2.forEach((element) {
  //       items.add(element);
  //     });
  //   } else {
  //     log(response2.statusCode.toString() +
  //         " : " +
  //         response2.reasonPhrase.toString());
  //   }
  // }
  //test cache
  //items2= _dataRepository.getAllDatas();
  return items.map((e) => Data.fromJson(e)).toList();
}

MediaType media = MediaType.Tous;

class _collectionPage extends State<collectionPage> {
  final DataRepository _dataRepository = DataRepository();

  _collectionPage(dynamic user);
  static get user => user;
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
                      color: Colors.black,
                      child: AppBar(
                          backgroundColor: Colors.black,
                          automaticallyImplyLeading: false,
                          title: Row(children: <Widget>[
                            Container(
                                width:
                                    (MediaQuery.of(context).size.width / 5) - 7,
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
                                width:
                                    (MediaQuery.of(context).size.width / 5) - 7,
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
                                width:
                                    (MediaQuery.of(context).size.width / 5) - 7,
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
                                width:
                                    (MediaQuery.of(context).size.width / 5) - 7,
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
                                width:
                                    (MediaQuery.of(context).size.width / 5) - 7,
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
                    future: ReadJsonData(media, _dataRepository, widget.user),
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
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
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
                                                                              item: items[index],
                                                                              user: this.widget.user,
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
