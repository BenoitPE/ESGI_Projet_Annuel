// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  final item;
  final user;
  const ItemsPage({Key? key, required this.item, required this.user})
      : super(key: key);

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
                              Text('Série TV',
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
                                        final response = await http.post(
                                          Uri.parse(
                                              'http://100.113.108.37:8081/addToWishlist?MediaType=' +
                                                  item.mediaType +
                                                  '&MediaId=' +
                                                  item.id +
                                                  '&Id=' +
                                                  user.idUser.toString()),
                                        );

                                        if (response.statusCode == 200) {
                                        } else {
                                          throw Exception('Failed');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
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
                                        final response = await http.post(
                                          Uri.parse(
                                              'http://100.113.108.37:8081/addToCollection?MediaType=' +
                                                  item.mediaType +
                                                  '&MediaId=' +
                                                  item.id +
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
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.play_circle_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
                                item.overview,
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

  @override
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
}

class rolesSection extends StatelessWidget {
  final item;

  rolesSection({required this.item});

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
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: item.properties['characters'].length,
              separatorBuilder: (context, _) => SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  buildCardRole(item: item, context: context, index: index),
            )),
      ]),
    );
  }
}

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
                      image: item.properties['characters'][index]
                                  ['profile_path'] !=
                              null
                          ? NetworkImage(item.properties['characters'][index]
                              ['profile_path'])
                          : AssetImage('image/NoUserImage.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    )))),
          ),
          const SizedBox(height: 4),
          Text(
              (item.properties['characters'][index]['name'] != null
                  ? item.properties['characters'][index]['name']
                  : ''),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 2),
          Text(
              (item.properties['characters'][index]['character'] != null
                  ? item.properties['characters'][index]['character']
                  : ''),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 10, color: Colors.white),
              maxLines: 2)
        ],
      ),
    );
