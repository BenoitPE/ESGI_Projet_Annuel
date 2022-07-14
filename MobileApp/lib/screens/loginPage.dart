import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_test/repository/user_repository.dart';
import 'package:flutter_project_test/screens/registerPage.dart';
import 'package:flutter_project_test/screens/searchPage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../models/data.dart';

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
                    buildEmail(myControllerUsername),
                    SizedBox(height: 10),
                    buildPassword(myControllerPassword),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () async {
                          final response = await http.post(
                            Uri.parse(
                                'http://100.113.108.37:8081/login?Username=' +
                                    myControllerUsername.text +
                                    '&Password=' +
                                    myControllerPassword.text),
                          );
                          if (myControllerUsername.text != "" &&
                              myControllerPassword.text != "" &&
                              response.statusCode == 200) {
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
                                              if (myControllerUsername.text ==
                                                      "" &&
                                                  myControllerPassword.text ==
                                                      "") {
                                                return "Veuillez saisir un identifiant \n et un password ";
                                              } else if (myControllerUsername
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un identifiant";
                                              } else if (myControllerUsername
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un password";
                                              } else {
                                                return "identifiant ou mots de passe \n incorrect ";
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
                    // buildLoginBtn(context, myControllerUsername.text,
                    //     myControllerPassword.text),
                    buildInfBtn(context)
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

Widget buildEmail(TextEditingController myControllerUsername) {
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

Widget buildInfBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
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
