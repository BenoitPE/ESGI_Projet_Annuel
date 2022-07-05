import 'package:flutter/material.dart';
import 'package:flutter_project_test/screens/loginPage.dart';

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
  
 @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black ,
      body : Column(
        children: [
          Container(
            alignment: Alignment.center,
            height : 200,
            margin: const EdgeInsets.only(top: 250.0,left: 20),
            child: const Text.rich(
              TextSpan(
                text: "N'oubliez plus ce \nque vous possédez.\n",
                style:  TextStyle(color: Colors.white , fontWeight: FontWeight.bold,fontSize: 30), // default text style
                children: <TextSpan>[
                  TextSpan(text: "Films, séries TV, animées et \nlivres, listez tout ce que vous \navez pour ne plus jamais \nl'oublier",
                   style: TextStyle(
                      color : Color(0xFF616161),
                      fontSize: 25
                      )
                    ),
                  ],
               ),
            ),
          ),
          const SizedBox(height : 20),
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
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: 20.0,right: 150, left: 150, bottom: 20),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                  },
                  child: const Text('Commencer'),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}