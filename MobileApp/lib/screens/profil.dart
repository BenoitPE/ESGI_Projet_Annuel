import 'dart:convert';
import 'package:Watchlist/repository/data_repository.dart';
import 'package:Watchlist/providers/whislist_cache_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../repository/user_repository.dart';
import 'loginPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class profilPage extends StatelessWidget {
  final user;
  const profilPage({Key? key, required this.user}) : super(key: key);

  //widget qui permet de crée l'affichage du la page profil
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
                            user.username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            width: double.infinity,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              elevation: 5,
                              onPressed: () async {
                                final UserRepository _userRepository = UserRepository();
                                final DataRepository _dataReposirory = DataRepository();
                                final WhislistCacheProvider _wishlistRepository = WhislistCacheProvider();
                                var users = await _userRepository.getAllUser();
                                await _dataReposirory.deleteAll();
                                await _wishlistRepository.deleteAll();
                                 if (users.length == 1){
                                  _userRepository.deleteUser(users[0]);
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginPage()),
                                );
                              },
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
                                          padding: EdgeInsets.fromLTRB(
                                              50, 25, 25, 25),
                                          child: FutureBuilder<String>(
                                            future: nbCollection(user),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.connectionState ==
                                                      ConnectionState.done) {
                                                return Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 43,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              }
                                              return CircularProgressIndicator();
                                            },
                                          )),
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
                                          padding: EdgeInsets.fromLTRB(
                                              50, 25, 25, 25),
                                          child: FutureBuilder<String>(
                                            future: nbWishlist(user),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.connectionState ==
                                                      ConnectionState.done) {
                                                return Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 43,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              }
                                              return CircularProgressIndicator();
                                            },
                                          )),
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

  //widget qui crée le fond d'écran
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
              image: AssetImage('image/backgroundBlack.webp'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
        ),
      );

//futur qui appel l'api afin davoir le nombre d'élement détenue par l'utilisateur dans sa collection 
  Future<String> nbCollection(dynamic user) async {
    var userApiUrl = dotenv.env['USERAPI_URL'] != null ? dotenv.env['USERAPI_URL'] : '';
    final response = await http.get(Uri.parse(
        userApiUrl.toString() + '/countMediaInUserCollection?Id=' +
            user.idUser.toString()));
    if (response.statusCode == 200) {
      var count = json.decode(response.body) as int;
      return count.toString();
    } else {
      log("error load data");
      return "0";
    }
  }

//futur qui appel l'api afin davoir le nombre d'élement détenue par l'utilisateur dans sa collection 
  Future<String> nbWishlist(dynamic user) async {
    var userApiUrl = dotenv.env['USERAPI_URL'] != null ? dotenv.env['USERAPI_URL'] : '';
    final response = await http.get(Uri.parse(
        userApiUrl.toString() + '/countMediaInUserWishlist?Id=' + user.idUser.toString()));
    if (response.statusCode == 200) {
      var count = json.decode(response.body) as int;
      return count.toString();
    } else {
      log("error load data");
      return "0";
    }
  }
}
