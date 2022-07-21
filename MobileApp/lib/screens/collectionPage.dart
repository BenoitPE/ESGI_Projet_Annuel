import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../models/data.dart';
//import '../repository/data_repository.dart';
import 'ItemsPage.dart';

class collectionPage extends StatefulWidget {
  final user;
  const collectionPage({
    this.user,
  });
  @override
  _collectionPage createState() => _collectionPage(user);
}

//fonction permattant de récupérer tout les élément présent dans la wishlist
Future<List<Data>> ReadJsonData(MediaType media, dynamic user) async {
  var list;
  var items = [];

    //appel de l'api
    final response =
        await http.get(Uri.parse('http://100.113.108.37:8081/getCollection?Id='+user.idUser.toString()));

    // vérification de l'appel plus ajout élément dans la liste 
    if (response.statusCode == 200) {
      list = json.decode(response.body) as List<dynamic>;
      log(response.reasonPhrase.toString());
      // verification du type pour l'affichage
      list.forEach((element) {
        if (media == MediaType.Movie && element['mediaType']=="Movie"){
          items.add(element);
        }else if  (media == MediaType.Book && element['mediaType']=="book"){
          items.add(element);
        }else if (media == MediaType.Anime && element['mediaType']=="anime"){
          items.add(element);
        }else if (media == MediaType.Serie && element['mediaType']=="Serie"){
          items.add(element);
        } else if (media == MediaType.Tous){
          items.add(element);
        }
      });
    } else {
      log(response.statusCode.toString() +
          " : " +
          response.reasonPhrase.toString());
    }
  return items.map((e) => Data.fromJson(e)).toList();
}

MediaType media = MediaType.Tous;

//création des éléments dans le statefullwidget
class _collectionPage extends State<collectionPage> {

  _collectionPage(dynamic user);
  // ignore: unused_element
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
                  // se widget permet d'appeler des futurs qui permet de faire des appels asynchrone et de gérer ce qui va être retourner
                  // en fonction du résultat
                  FutureBuilder(
                    future: ReadJsonData(media, widget.user), //_dataRepository,
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

// widget permettant de crée le text 
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
