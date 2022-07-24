// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ItemsPage extends StatelessWidget {
  final item;
  final user;

  const ItemsPage({Key? key, required this.item, required this.user})
      : super(key: key);
//widget qui crée la page item page avec différentes information comme le titre le synopsyse etc ...
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          buildBackground(),
          Material(
              type: MaterialType.transparency,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 400, 0, 0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(capitalize(item.mediaType),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: IconButton(
                                      onPressed: () async {
                                        var userApiUrl =
                                            dotenv.env['USERAPI_URL'] != null
                                                ? dotenv.env['USERAPI_URL']
                                                : '';
                                        final response = await http.post(
                                          Uri.parse(userApiUrl.toString() +
                                              '/addToWishlist?MediaType=' +
                                              item.mediaType +
                                              '&MediaId=' +
                                              item.id.toString() +
                                              '&Id=' +
                                              user.idUser.toString()),
                                        );

                                        if (response.statusCode == 200) {
                                        } else {
                                          throw Exception('Failed');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                      onPressed: () async {
                                        var userApiUrl =
                                            dotenv.env['USERAPI_URL'] != null
                                                ? dotenv.env['USERAPI_URL']
                                                : '';
                                        final response = await http.post(
                                          Uri.parse(userApiUrl.toString() +
                                              '/addToCollection?MediaType=' +
                                              item.mediaType +
                                              '&MediaId=' +
                                              item.id.toString() +
                                              '&Id=' +
                                              user.idUser.toString()),
                                        );
                                        if (response.statusCode == 200) {
                                        } else {
                                          throw Exception('Failed');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.folder,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  (item.properties['trailerUrl'] != null &&
                                          item.properties['trailerUrl'] != '')
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                            onPressed: () async {
                                              if (item.properties[
                                                          'trailerUrl'] !=
                                                      null &&
                                                  item.properties[
                                                          'trailerUrl'] !=
                                                      '') {
                                                final url = item
                                                    .properties['trailerUrl']
                                                    .toString();
                                                // ignore: deprecated_member_use
                                                await launch(url,
                                                    forceWebView: true,
                                                    enableJavaScript: true);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.play_circle_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              )
                            ],
                          )),
                      rolesSection(item: item),
                      Container(
                        child: Column(children: [
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Column(children: [
                              Text(
                                'Synopsis',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              SizedBox(height: 10),
                              Text(
                                item.overview != null
                                    ? item.overview
                                        .replaceAll('<br>', '')
                                        .replaceAll('<i>', '')
                                    : '',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              )
                            ]),
                          ),
                        ]),
                      ),
                      Container(
                        height: 100,
                      )
                    ],
                  ),
                ),
              )),
        ],
      );

  Widget buildBackground() => ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.transparent, Colors.black],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: item.imageUrl != null
                  ? NetworkImage(item.imageUrl)
                  : AssetImage('image/NoImage.jpg') as ImageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
        ),
      );

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class rolesSection extends StatelessWidget {
  final item;

  rolesSection({required this.item});

//widget qui crée la liste pour recevoir les informations des personnages
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: Column(children: [
        Container(
          height: 50,
          child: Row(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Distribution des rôles',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        Container(
            height: item.properties['authorName'] != null ? 260 : 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: item.properties['characters'] != null
                  ? item.properties['characters'].length
                  : item.properties['personnages'] != null
                      ? item.properties['personnages'].length
                      : item.properties['authorName'] != null
                          ? item.properties['authorName']
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .split(',')
                              .length
                          : 0,
              separatorBuilder: (context, _) => SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  buildCardRole(item: item, context: context, index: index),
            )),
      ]),
    );
  }
}

//widget qui permet de crée l'information d'un acteurs / personnage d'un contenue
Widget buildCardRole(
        {required item, required BuildContext context, required index}) =>
    Container(
      width: 100,
      child: Column(
        children: [
          Container(
            height: 150,
            child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                        child: Ink.image(
                      image: item.properties['characters'] != null &&
                              item.properties['characters'][index]
                                      ['profile_path'] !=
                                  null
                          ? NetworkImage(item.properties['characters'][index]
                              ['profile_path'])
                          : item.properties['personnages'] != null &&
                                  item.properties['personnages'][index]
                                          .imageUrl !=
                                      null &&
                                  item.properties['personnages'][index]
                                          .imageUrl !=
                                      ""
                              ? NetworkImage(item
                                  .properties['personnages'][index].imageUrl)
                              : AssetImage('image/NoUserImage.png')
                                  as ImageProvider,
                      fit: BoxFit.cover,
                    )))),
          ),
          const SizedBox(height: 4),
          Text(
              (item.properties['characters'] != null &&
                      item.properties['characters'][index]['name'] != null
                  ? item.properties['characters'][index]['name']
                  : item.properties['personnages'] != null &&
                          item.properties['personnages'][index].name != null
                      ? item.properties['personnages'][index].name
                      : item.properties['authorName'] != null
                          ? item.properties['authorName']
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .split(',')[index]
                          : ''),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 2),
          Text(
              (item.properties['characters'] != null &&
                      item.properties['characters'][index]['character'] != null
                  ? item.properties['characters'][index]['character']
                  : item.properties['personnages'] != null &&
                          item.properties['personnages'][index].character !=
                              null
                      ? item.properties['personnages'][index].character
                      : item.properties['authorName'] != null
                          ? 'Auteur'
                          : ''),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 10, color: Colors.white),
              maxLines: 2)
        ],
      ),
    );
