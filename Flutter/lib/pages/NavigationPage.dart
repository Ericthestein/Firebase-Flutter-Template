import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutterdemo/data/PageInfo.dart';

// Import bottom navigation pages
import 'package:firebaseflutterdemo/pages/bottomNavigationPages/AuthenticationPage.dart';
import 'package:firebaseflutterdemo/pages/bottomNavigationPages/CloudFirestorePage.dart';
import 'package:firebaseflutterdemo/pages/bottomNavigationPages/CloudFunctionsPage.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  static List<PageInfo> pages = <PageInfo>[
    PageInfo(
      title: "Authentication",
      icon: Icon(Icons.fingerprint),
      page: AuthenticationPage()
    ),
    PageInfo(
        title: "Cloud Firestore",
        icon: Icon(Icons.cloud),
        page: CloudFirestorePage()
    ),
    PageInfo(
      title: "Cloud Functions",
      icon: Icon(Icons.http),
      page: CloudFunctionsPage()
    )
  ];

  @override
  NavigationPageState createState() {
    return new NavigationPageState(pages: pages);
  }
}

class NavigationPageState extends State<NavigationPage> {
  NavigationPageState({@required this.pages}) : super() {
    // begin monitoring authentication state
    this.monitorAuthenticationState();
  }

  // Pages
  List<PageInfo> pages;
  int selectedIndex = 0;
  onItemTapped(int index) {
    // if not authenticated, prevent user from accessing other pages
    if (this.user == null && !allowNavigationIfNotLoggedIn) return;
    setState(() {
      selectedIndex = index;
    });
  }

  // Authentication
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  bool allowNavigationIfNotLoggedIn = false; // must be logged in to navigate to other pages
  monitorAuthenticationState() {
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        print("Navigation: User logged in");
      } else {
        print("Navigation: User logged out");
        if (!allowNavigationIfNotLoggedIn) { // bring back to auth screen
          setState(() {
            selectedIndex = 0;
          });
        }
      }
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(selectedIndex).page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (PageInfo page in pages)
            BottomNavigationBarItem(
              icon: page.icon,
              label: page.title,
            )
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}