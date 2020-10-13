import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestorePage extends StatefulWidget {
  CloudFirestorePage({Key key}) : super(key: key);

  @override
  CloudFirestorePageState createState() {
    return new CloudFirestorePageState();
  }
}

class CloudFirestorePageState extends State<CloudFirestorePage> {
  CloudFirestorePageState(): super() {
    this.getData();
    this.monitorAuthenticationState();
  }

  // Authentication

  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  monitorAuthenticationState() {
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        print("CloudFirestore: User logged in");
      } else {
        print("CloudFirestore: User logged out");
      }
      setState(() {
        this.user = user;
      });
    });
  }

  // Data

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getData() {
    firestore.collection("election").snapshots().listen((querySnapshot) {
      List<QueryDocumentSnapshot> docSnapshots = querySnapshot.docs;
      docSnapshots.forEach((docSnapshot) {
        Map<String, dynamic> data = docSnapshot.data();
        if (data["name"] != null) {
          switch (data["name"]) {
            case "cats":
              setState(() {
                catVotes = data["votes"] as int;
              });
              break;
            case "dogs":
              setState(() {
                dogVotes = data["votes"] as int;
              });
              break;
          }
        }
      });
    });
  }

  int dogVotes = 0;
  int catVotes = 0;

  addVote(user, selection) {
    firestore.collection("election").doc(selection).set({
      "name": selection,
      "votes": (selection == "dogs" ? dogVotes : catVotes) + 1
    }).then((value) => {

    }).catchError((err) => {
      print("Error voting: " + err)
    });
  }

  onDogVote() {
    addVote(user, "dogs");
  }

  onCatVote() {
    addVote(user, "cats");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Cloud Firestore"),
            backgroundColor: Colors.orange
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    "Cats or dogs?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 36
                    )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Row(
                    children: [
                      VoteOption(
                          image: AssetImage("images/cats.jpg"),
                          title: "Cats",
                          onVote: this.onCatVote,
                          votes: this.catVotes
                      ),
                      VoteOption(
                          image: AssetImage("images/dogs.jpg"),
                          title: "Dogs",
                          onVote: this.onDogVote,
                          votes: this.dogVotes
                      )
                    ]
                ),
              )
            ],
          )
        )
    );
  }
}

class VoteOption extends StatelessWidget {
  VoteOption({this.image, this.title, this.onVote, this.votes}) : super();

  ImageProvider image;
  String title;
  Function onVote;
  int votes;

  @override
  Widget build(BuildContext context) {
    return(
        Expanded(
            flex: 1,
            child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                        fit: BoxFit.fill,
                        height: 250,
                        image: image
                    )
                  ),
                  Text(
                    "$title"
                  ),
                  Text(
                    "Votes: $votes"
                  ),
                  ElevatedButton(
                    onPressed: onVote,
                    child: Text('Vote'),
                  )
                ]
            )
        )
    );
  }
}