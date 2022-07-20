import 'package:flutter/material.dart';
import 'package:flutter_project_test/repository/user_repository.dart';
import 'package:flutter_project_test/screens/loginPage.dart';
import 'package:flutter_project_test/screens/searchPage.dart';

import 'models/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design1',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {

  final UserRepository _userRepository = UserRepository();
  List<User> users = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            margin: const EdgeInsets.only(top: 250.0, left: 20),
            child: const Text.rich(
              TextSpan(
                text: "N'oubliez plus ce \nque vous possédez.\n",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30), // default text style
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "Films, séries TV, animées et \nlivres, listez tout ce que vous \navez pour ne plus jamais \nl'oublier",
                      style: TextStyle(color: Color(0xFF616161), fontSize: 25)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFE53935),
                          Color(0xFFE53935),
                          Color(0xFFE53935),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () async {
                      // vérification du cache si il est remplie ou non pour renvoyer à une page différente 
                      users = await _userRepository.getAllUser();
                      if(users.length == 1)
                      {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => searchPage(user: users[0])),
                      );
                      }else 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loginPage()),
                      );
                    },
                    padding: EdgeInsets.all(22),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.red,
                    child: Text(
                      'Commencer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}