import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes/data/repositories/articles_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';

class FirebaseArticlesRepository implements ArticlesRepository{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  

  @override
  Future<List<Article>> getArticles() async {

    CollectionReference articles = firestore.collection("articles");
    List<Article> listArticles = [];
    try {
      QuerySnapshot querySnapshot = await articles.get();
      for (var doc in querySnapshot.docs) { 
        listArticles.add(Article(id: doc.id, title: doc['title'], body: doc['body'], author: doc['author'], category: doc['category'], imageUrl: doc['imageUrl'], view: doc['view']));
      }
      print('!!!!!!!!!!!!!!!!!!!!!!!$listArticles');
    } catch (e) {
      print('Error fetching data: $e');
    }
    return listArticles;
  }
  
  @override
  Future<void> incrementViews(String id) async {
    CollectionReference articles = firestore.collection("articles");

    final DocumentSnapshot documentSnapshot = await articles.doc(id).get();
    final article = documentSnapshot.data() as Map<String, dynamic>;

    int inc = article['view'] + 1;
    print(inc);
    
    await articles.doc(id).update({"view": inc});

  }



}