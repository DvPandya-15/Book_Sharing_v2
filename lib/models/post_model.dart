import 'package:book_sharing_app/pages/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  Book book;
  String timestamp;
  User user;
  String availability;

  PostModel({
    this.book,
    this.user,
    this.timestamp,
    this.availability,
  });
}

class Book {
  String title="";
  String author ="";
  List genres = [];
  String imageUrl;

  Book({this.title, this.author, this.genres, this.imageUrl});

  Book.fromSnapshot(DocumentSnapshot snapshot) {
    title = snapshot["title"];
    author = snapshot["author"];
    genres = snapshot["genres"];
    imageUrl = snapshot["imageUrl"];
  }

  Book.fromMap(Map<String, dynamic> snapshot) {
    print(snapshot["title"]);
    title = snapshot["title"];
    author = snapshot["author"];
    genres = snapshot["genres"];
    imageUrl = snapshot["imageUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "author": this.author,
      "genres": this.genres,
      "imageUrl": this.imageUrl,
    };
  }

  @override
  String toString() {
    return 'Book{title: $title, author: $author, genres: $genres, imageUrl: $imageUrl}';
  }
}

