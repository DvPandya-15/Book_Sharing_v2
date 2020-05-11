import 'package:book_sharing_app/models/post_model.dart';
import 'package:book_sharing_app/pages/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//class Snapshot {
//  final String title;
//  final String description;
//
//  Snapshot(this.title, this.description);
//}

class BookPage extends StatelessWidget {
  DocumentSnapshot doc;

  BookPage(this.doc);

//
//  // In the constructor, require a Todo.
//  BookPage({Key key, @required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Book Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("books")
              .document(doc["book"])
              .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Container();
            final book = Book.fromSnapshot(snapshot.data);
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                              book.imageUrl == null || book.imageUrl.isEmpty ? AssetImage(
                                  "assets/book_placeholder.png") : NetworkImage(
                                  book.imageUrl)),
                            ),
                            width: 100,
                            height: 150,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(book.author,
                                    style: TextStyle(fontSize: 14)),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "10th March, 2020",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(height: 1,color: Colors.black,),
                      Text(
                        "--Users Who Are Donating--",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(height: 1,color: Colors.black,),
                      StreamBuilder(
                        stream: Firestore.instance
                            .collection("users")
                            .document(doc["user"])
                            .snapshots(),
                        builder: (context, snapshot) {
                          final bUser = User.fromSnapshot(snapshot.data);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                bUser.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
