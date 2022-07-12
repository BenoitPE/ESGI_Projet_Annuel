import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_test/screens/loginPage.dart';
import 'package:flutter_project_test/screens/searchPage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class registerPage extends StatelessWidget {
  late TextEditingController myControllerUsername = TextEditingController();
  late TextEditingController myControllerPassword = TextEditingController();
  late TextEditingController myControllerEmail = TextEditingController();

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
                    buildUsername(myControllerUsername),
                    SizedBox(height: 10),
                    buildPassword(myControllerPassword),
                    SizedBox(height: 10),
                    buildEmail(myControllerEmail),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () async {
                          final response = await http.post(
                            Uri.parse('http://100.113.108.37:8081/addUser'),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode({
                              'username': myControllerUsername.text,
                              'email': myControllerEmail.text,
                              'password': myControllerPassword.text,
                            }),
                          );

                          if (myControllerUsername.text != "" &&
                              myControllerPassword.text != "" &&
                              myControllerEmail.text != "" &&
                              response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginPage()),
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
                                          //height: MediaQuery.of(context).size.height/6,
                                          child: Row(children: [
                                            Text((() {
                                              if (myControllerUsername.text == "" &&
                                                  myControllerPassword.text ==
                                                      "" &&
                                                  myControllerEmail.text ==
                                                      "") {
                                                return "Veuillez saisir un identifiant \n , un password et mail ";
                                              } else if (myControllerUsername
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un identifiant";
                                              } else if (myControllerUsername
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un password";
                                              } else if (myControllerEmail
                                                      .text ==
                                                  "") {
                                                return "Veuillez saisir un Email";
                                              } else {
                                                return "identifant ou mots de passe \n déja utilisée ";
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
                          "S'inscrire",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

Widget buildUsername(myControllerUsername) {
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

Widget buildPassword(myControllerPassword) {
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

Widget buildEmail(myControllerEmail) {
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
            controller: myControllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 14),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
          ),
        )
      ]);
}

// Widget buildInscriptionBtn(BuildContext context) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 7),
//     width: double.infinity,
//     child: RaisedButton(
//       elevation: 5,
//       onPressed: () async {
//                           final response = await http.post(
//                             Uri.parse(
//                                 'http://100.113.108.37:8081/login?Username=' +
//                                     myControllerUsername.text +
//                                     '&Password=' +
//                                     myControllerPassword.text),
//                             headers: {
//                               'Content-Type': 'application/json; charset=UTF-8',
//                             },
//                             body: jsonEncode({
//                               //'idUser': idUser,
//                               'username': myControllerUsername.text,
//                               //'email': email,
//                               'password': myControllerPassword.text,
//                             }),
//                           );

//                           if (myControllerUsername.text != "" &&
//                               myControllerPassword.text != "" &&
//                               response.statusCode == 200) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => searchPage()),
//                             );
//                           } else {
//                             showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Column(
//                                       children: [
//                                         Container(
//                                           //height: MediaQuery.of(context).size.height/6,
//                                           child: Row(children: [
//                                             Text((() {
//                                               if (myControllerUsername.text ==
//                                                       "" &&
//                                                   myControllerPassword.text ==
//                                                       "") {
//                                                 return "Veuillez saisir un identifiant \n et un password ";
//                                               } else if (myControllerUsername
//                                                       .text ==
//                                                   "") {
//                                                 return "Veuillez saisir un identifiant";
//                                               } else if (myControllerUsername
//                                                       .text ==
//                                                   "") {
//                                                 return "Veuillez saisir un password";
//                                               } else {
//                                                 return "identifant ou mots de passe déja utilisée ";
//                                               }
//                                             })()),
//                                           ]),
//                                         ),
//                                         const CloseButton(),
//                                       ],
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   );
//                                 });
//                           }
//                         },,
//       padding: EdgeInsets.all(15),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: Colors.red,
//       child: Text(
//         "S'inscrire",
//         style: TextStyle(
//             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     ),
//   );
// }
