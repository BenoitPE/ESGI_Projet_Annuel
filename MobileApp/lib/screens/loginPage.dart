import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Watchlist/repository/user_repository.dart';
import 'package:Watchlist/screens/registerPage.dart';
import 'package:Watchlist/screens/searchPage.dart';
import 'package:http/http.dart' as http;
import '../models/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class loginPage extends StatefulWidget {

  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPage createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  late TextEditingController myControllerUsername = TextEditingController();
  late TextEditingController myControllerPassword = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    buildUseName(myControllerUsername),
                    SizedBox(height: 10),
                    buildPassword(myControllerPassword),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5,
                        // parti asynchrone permettant de se connecter vérification cotée api 
                        onPressed: () async {
                          var userApiUrl = dotenv.env['USERAPI_URL'] != null ? dotenv.env['USERAPI_URL'] : '';
                          if (myControllerUsername.text != "" &&
                              myControllerPassword.text != "") {
                          final response = await http.post(
                            Uri.parse(
                                userApiUrl.toString() + '/login?Username=' +
                                    myControllerUsername.text +
                                    '&Password=' +
                                    myControllerPassword.text),
                            );
                          if(response.statusCode == 200) {
                              var user = User.fromJson(jsonDecode(response.body));
                              _userRepository.addUser(user);
                              Navigator.push(
                                context,
                                MaterialPageRoute (
                                    builder: (context) => searchPage(user: user)),
                              );
                            } else {
                                showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Container(
                                          child: Row(children: [
                                            Text((() {
                                              return "identifiant ou mots \nde passe incorrect  ";
                                            })()),
                                          ]),
                                        ),
                                        const CloseButton(),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  );
                                });
                            }
                          } else {
                            //une popup d'alerte permet de prevenir si il manque des informations renseignée
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Container(
                                          child: Row(children: [
                                            Text((() {
                                              if (myControllerUsername.text ==
                                                      "" &&
                                                  myControllerPassword.text ==
                                                      "") {
                                                return "Veuillez saisir un identifiant \n et un password ";
                                              } else if (myControllerUsername
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un identifiant";
                                              } else {
                                                return "Veuillez saisir un password";
                                              }
                                            })()),
                                          ]),
                                        ),
                                        const CloseButton(),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  );
                                });
                          }
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.red,
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    buildInfBtn(context)
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

//widget qui crée la partie username 
Widget buildUseName(TextEditingController myControllerUsername) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: myControllerUsername,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 14),
                hintText: 'Identifiant',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
          ),
        )
      ]);
}

//widget qui crée la partie mot de passe  
Widget buildPassword(TextEditingController myControllerPassword) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: myControllerPassword,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 14),
                hintText: 'Mot de passe',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
          ),
        )
      ]);
}

//widget qui permet de renvoyer vers la page registerPage afin de s'enregistrer 
Widget buildInfBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    // ignore: deprecated_member_use
    child: FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => registerPage()),
        );
      },
      child: Text(
        "C'est votre première visite ?",
        style: TextStyle(
          color: Color(0xFF616161),
        ),
      ),
    ),
  );
}
