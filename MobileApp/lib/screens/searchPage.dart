import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_project_test/screens/ItemsPage.dart';
import 'package:flutter_project_test/screens/profil.dart';
import 'package:flutter_project_test/screens/wishlistPage.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:flutter_project_test/data.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import "dart:io";
import 'collectionPage.dart';

class searchPage extends StatefulWidget {
  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<searchPage> {
  int currentIndex = 1;
  final screens = [
    wishlistPage(),
    collectionPage(),
    containerSearch(),
    profilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
              ),
              label: ("wishlist"),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
                color: Colors.white,
              ),
              label: ("collection"),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: ("search"),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              label: ("profil"),
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}

class CardItem {
  final urlImage;

  const CardItem({required this.urlImage});
}

class TestItem {
  String label;
  dynamic value;
  TestItem({required this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}

class itemSection extends StatelessWidget {
  String name;
  String titre;
  MediaType media;
  dynamic myController;
  dynamic test;

  ImageProvider<Object> urlImage(item, name) {
    if (item.imageUrl != null) {
      return item.imageUrl != null
          ? NetworkImage(item.imageUrl)
          : AssetImage('image/NoImage.jpg') as ImageProvider;
    } else
      return AssetImage('image/NoImage.jpg') as ImageProvider;
  }

  itemSection(this.name, this.titre, this.media, this.myController);

  late Future<List<Data>> futureData;

  Future<List<Data>> ReadJsonData(
      String myController, MediaType media) async {
    var list;
    var list2;
    var items = [];
    debugPrint(myController);

    if (media == MediaType.Movie || media == MediaType.Tous) {
      final response =
          await http.get(Uri.parse('http://100.113.108.37/Movie/Popular'));

      if (response.statusCode == 200) {
        list = json.decode(response.body) as List<dynamic>;
        log(response.reasonPhrase.toString());
        list.forEach((element) {
          items.add(element);
        });
      } else {
        log(response.statusCode.toString() +
            " : " +
            response.reasonPhrase.toString());
      }
    }

    if (media == MediaType.Serie || media == MediaType.Tous) {
      final response2 =
          await http.get(Uri.parse('http://100.113.108.37/Serie/Popular'));

      if (response2.statusCode == 200) {
        list2 = json.decode(response2.body) as List<dynamic>;
        log(response2.reasonPhrase.toString());
        list2.forEach((element) {
          items.add(element);
        });
      } else {
        log(response2.statusCode.toString() +
            " : " +
            response2.reasonPhrase.toString());
      }
    }
    return items.map((e) => Data.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    futureData = ReadJsonData(myController, media);
    // var textController = myController.text;
    // var textRayane = "test";
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: Column(children: [
        Container(
          height: 50,
          child: Row(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Voir plus',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        FutureBuilder(
          future: futureData,
          builder: (context, data) {
            if (data.hasError) {
              return Text('error');
            } else if (data.hasData) {
              var items = data.data as List<Data>;
              if (items.length != 0) {
                return Container(
                    height: 140,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        separatorBuilder: (context, _) => SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            child: Column(
                              children: [
                                Expanded(
                                    child: AspectRatio(
                                        aspectRatio: 4 / 3,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Material(
                                                child: Ink.image(
                                                    image: urlImage(
                                                        items[index], name),
                                                    fit: BoxFit.cover,
                                                    child: InkWell(
                                                        onTap:
                                                            () =>
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ItemsPage(
                                                                              item: items[index])),
                                                                ))))))),
                              ],
                            ),
                          );
                        }));
              } else {
                return Container();
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}

class containerSearch extends StatefulWidget {
  @override
  _containerSearch createState() => _containerSearch();
}

class _containerSearch extends State<containerSearch> {
  TextEditingController myController = TextEditingController();
  late String titre = '';

  Future<List> fetchData() async {
    await Future.delayed(Duration(milliseconds: 3000));
    String _inputText = myController.text;
    final jsonData =
        await rootBundle.rootBundle.loadString('jsonfile/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    var listFinale = list
        .map((e) {
          var titlejson =
              e['title'].toUpperCase().substring(0, _inputText.length);
          if (titlejson.toUpperCase() == _inputText.toUpperCase()) {
            return Data.fromJson(e);
          }
        })
        .whereNotNull()
        .toList();

    return listFinale;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 40),
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(23),
              ),
              child: TextFieldSearch(
                itemsInView: 10,
                minStringLength: 0,
                label: '',
                controller: myController,
                future: () {
                  return fetchData();
                },
                getSelectedValue: (value) => setState(() {
                  print(value);
                  titre = value.label;
                }),
                textStyle: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: IconButton(
                        onPressed: () => setState(() {}),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    hintText: 'Recherche un film, une série, un livre ...',
                    hintStyle: TextStyle(color: Colors.white)),
              )),
          SizedBox(height: 20),
          itemSection("Films", titre, MediaType.Movie, myController.text),
          itemSection("Série", titre, MediaType.Serie, myController.text),
          itemSection("Animée", titre, MediaType.Anime, myController.text),
          itemSection("Livres", titre, MediaType.Book, myController.text)
        ])));
  }
}
