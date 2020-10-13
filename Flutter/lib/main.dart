import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

// Import root pages
import 'package:firebaseflutterdemo/pages/ErrorPage.dart';
import 'package:firebaseflutterdemo/pages/NavigationPage.dart';
import 'package:firebaseflutterdemo/pages/LoadingPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: "Firebase Flutter Demo",
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorPage();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return NavigationPage();
          }

          return LoadingPage();
        }
    );
  }
}