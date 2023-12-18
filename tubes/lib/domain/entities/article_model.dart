
import 'package:cloud_firestore/cloud_firestore.dart';

class Article{
  final String id;
  final String title;
  final String body;
  final String author;
  final String category;
  final String imageUrl;
  int view;
  final Timestamp createdAt;

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.category,
    required this.imageUrl,
    required this.view,
    required this.createdAt,
  });
}
