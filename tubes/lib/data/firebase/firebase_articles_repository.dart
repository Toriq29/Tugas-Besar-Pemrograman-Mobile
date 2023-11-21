import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes/data/repositories/articles_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';

class FirebaseArticlesRepository implements ArticlesRepository{
  @override
  Future<List<Article>> getArticles() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference articles = firestore.collection("articles");
    List<Article> listArticles = [];
    try {
      QuerySnapshot querySnapshot = await articles.get();
      for (var doc in querySnapshot.docs) { 
        listArticles.add(Article(id: doc.id, title: doc['title'], body: doc['body'], author: doc['author'], category: doc['category'], imageUrl: doc['imageUrl'], view: doc['view'], createdAt: doc['createdAt']));
      }
      print('!!!!!!!!!!!!!!!!!!!!!!!$listArticles');
    } catch (e) {
      print('Error fetching data: $e');
    }
    return listArticles;
  }

}