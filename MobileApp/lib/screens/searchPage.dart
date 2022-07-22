import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Watchlist/screens/ItemsPage.dart';
import 'package:Watchlist/screens/profil.dart';
import 'package:Watchlist/screens/wishlistPage.dart';
import 'package:Watchlist/models/data.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'collectionPage.dart';

class searchPage extends StatefulWidget {
  final user;
  const searchPage({
    this.user,
  });

  @override
  _searchPage createState() => _searchPage(user);
}

// création d'une partie de la searchPage , le composant crée ici est la bottom bar permettant de naviger entre les pages 
class _searchPage extends State<searchPage> {
  _searchPage(final user);

  // ignore: unused_element
  static get user => user;

  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final screens = [
      wishlistPage(user: this.widget.user),
      collectionPage(user: this.widget.user),
      containerSearch(user: this.widget.user),
      profilPage(user:this.widget.user),
    ];
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

// ignore: must_be_immutable
class itemSection extends StatelessWidget {
  String name;
  String titre;
  MediaType media;
  dynamic myController;
  dynamic test;
  dynamic user;

  // fonction permettant de gérer si il manque une image dans les données pour en affichée une par défault 
  ImageProvider<Object> urlImage(item, name) {
    if (item.imageUrl != null) {
      return item.imageUrl != null
          ? NetworkImage(item.imageUrl)
          : AssetImage('image/NoImage.jpg') as ImageProvider;
    } else
      return AssetImage('image/NoImage.jpg');
  }

  itemSection(this.name, this.titre, this.media, this.myController, this.user);

  late Future<List<Data>> futureData;

  // fonction asynchrone permattant de faires des appels api et de traité les données récupérer 
  Future<List<Data>> ReadJsonData(String myController, MediaType media) async {
    var list;
    var list2;
    var list3;
    var list4;
    var items = [];
    debugPrint(myController);

    // fait les appels et traintement de donnée lors d'une recherche en fonction des types de données 
    if (myController != "") {
      if (media == MediaType.Movie || media == MediaType.Tous) {
        final response = await http.get(
            Uri.parse('http://100.113.108.37/Movie/Search/' + myController));

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
        final response2 = await http.get(
            Uri.parse('http://100.113.108.37/Serie/Search/' + myController));

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

      if (media == MediaType.Anime || media == MediaType.Tous) {
        final response3 = await http.get(
            Uri.parse('http://100.113.108.37:8083/anime?name=' + myController));

        if (response3.statusCode == 200) {
          list3 = json.decode(response3.body) as List<dynamic>;
          log(response3.reasonPhrase.toString());
          list3.forEach((element) {
            if(element['adult']== false){
              items.add(element);
            }      
          });
        } else {
          log(response3.statusCode.toString() +
              " : " +
              response3.reasonPhrase.toString());
        }
      }

      if (media == MediaType.Book || media == MediaType.Tous) {
        final response4 = await http.get(
            Uri.parse('http://100.113.108.37:8080/getBookFromApiByTitle?title=' + myController)); //http://100.113.108.37:8080/getBookFromApiByTitle?title=Harry%20Potter

        if (response4.statusCode == 200) {
          list4 = json.decode(response4.body);
          log(response4.reasonPhrase.toString());
          items.add(list4);
        } else {
          log(response4.statusCode.toString() +
              " : " +
              response4.reasonPhrase.toString());
        }
      }
    } 
    // fait les appels et traintement de donnée si il n'y as pas de recherche éffectuée 
    else {
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

      if (media == MediaType.Anime || media == MediaType.Tous) {
        final response3 = await http.get(
            Uri.parse('http://100.113.108.37/Serie/Search/'));

        if (response3.statusCode == 200) {
          list3 = json.decode(response3.body) as List<dynamic>;
          log(response3.reasonPhrase.toString());
          list3.forEach((element) {
            items.add(element);
          });
        } else {
          log(response3.statusCode.toString() +
              " : " +
              response3.reasonPhrase.toString());
        }
      }

      if (media == MediaType.Book || media == MediaType.Tous) {
        final response4 = await http.get(
            Uri.parse('http://100.113.108.37:8080/getBooksFromApi'));

        if (response4.statusCode == 200) {
          list4 = json.decode(response4.body) as List<dynamic>;
          log(response4.reasonPhrase.toString());
          list4.forEach((element) {
            items.add(element);
          });
        } else {
          log(response4.statusCode.toString() +
              " : " +
              response4.reasonPhrase.toString());
        }
      }
    }

    return items.map((e) => Data.fromJson(e)).toList();
  }

  // ensemble de widget permettant l'affichage des données des différents type de donnée 
  @override
  Widget build(BuildContext context) {
    futureData = ReadJsonData(myController, media);
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
        // se widget permet d'appeler des futurs qui permet de faire des appels asynchrone et de gérer ce qui va être retourner 
        // en fonction du résultat 
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
                                                                              item: items[index],
                                                                              user: user,
                                                                            )),
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
  final user;
  const containerSearch({
    this.user,
  });
  @override
  _containerSearch createState() => _containerSearch(user);
}

//création des éléments dans le statefullwidget ici la partie recherche et appeles les widgets ItemSection
class _containerSearch extends State<containerSearch> {
  late TextEditingController myController = TextEditingController();
  late String titre = '';

  _containerSearch(user);

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
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (String value) => setState(() {}),
                controller: myController,
                style: TextStyle(color: Colors.white),
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
          itemSection("Films", titre, MediaType.Movie, myController.text, this.widget.user),
          itemSection("Série", titre, MediaType.Serie, myController.text, this.widget.user),
          itemSection("Animée", titre, MediaType.Anime, myController.text, this.widget.user),
          itemSection("Livres", titre, MediaType.Book, myController.text, this.widget.user)
        ])));
  }
}
