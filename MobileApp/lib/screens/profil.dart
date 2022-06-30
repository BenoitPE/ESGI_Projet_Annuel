import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_test/main.dart';
import 'package:flutter_project_test/screens/searchPage.dart';

class profilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          buildBackground(),
          Material(
            type: MaterialType.transparency,
            child: Container(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 150),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red.withOpacity(0.4),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.face,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Benoit PEGAZ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5,
                              onPressed: () {},
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.red.withOpacity(0.7),
                              child: Text(
                                'Déconnexion',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.withOpacity(0.4),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 25, 25, 25),
                                        child: Text(
                                          '32',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 43,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 15, 10),
                                          child: Text(
                                            'éléments \ncollectionnés',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 20,
                                            ),
                                          ))
                                    ],
                                  ))),
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.withOpacity(0.4),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 25, 25, 25),
                                        child: Text(
                                          '45',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 43,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 15, 10),
                                          child: Text(
                                            'éléments dans la \nliste de souhaits',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 20,
                                            ),
                                          ))
                                    ],
                                  )))
                        ],
                      )),
                ],
              ),
            ),
          ),
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
              image: NetworkImage(
                  'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive.jpg'),
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
