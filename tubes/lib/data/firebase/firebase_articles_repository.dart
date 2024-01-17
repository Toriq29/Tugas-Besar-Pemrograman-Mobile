import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes/data/repositories/articles_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';

class FirebaseArticlesRepository implements ArticlesRepository{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  

  @override
  Future<List<Article>> getArticles() async {

    CollectionReference articles = firestore.collection("articles");
    List<Article> listArticles = [];
    List<Article> listArticlesSwap = [];
    try {
      QuerySnapshot querySnapshot = await articles.get();
      for (var doc in querySnapshot.docs) {

        QuerySnapshot bodiesSnapshots  = await doc.reference.collection("Bodies").get();
        List<String> bodies = bodiesSnapshots.docs.map((bodyDoc) => (bodyDoc.data() as Map<String, dynamic>)['body'] as String).toList();
        listArticles.add(Article(id: doc.id, title: doc['title'], body: bodies, author: doc['author'], category: doc['category'], imageUrl: doc['imageUrl'], view: doc['view']));


      }

      for (var i = listArticles.length-1 ; i >= 0  ; i--) {
        if (listArticles[i].category == "Nasional" ||listArticles[i].category == "Internasional" ||listArticles[i].category == "Ekonomi" ||listArticles[i].category == "Olahraga" ||listArticles[i].category == "Otomotif") {
          listArticlesSwap.add(listArticles[i]);
          
        }
      }
      
    } catch (e) {
      print('Error fetching data: $e');
    }
    return listArticlesSwap;
  }
  
  @override
  Future<void> incrementViews(String id) async {
    CollectionReference articles = firestore.collection("articles");

    final DocumentSnapshot documentSnapshot = await articles.doc(id).get();
    final article = documentSnapshot.data() as Map<String, dynamic>;

    int inc = article['view'] + 1;
    
    await articles.doc(id).update({"view": inc});

  }

}