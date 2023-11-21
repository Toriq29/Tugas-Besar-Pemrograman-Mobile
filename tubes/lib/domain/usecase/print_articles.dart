import 'package:tubes/data/repositories/articles_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/domain/usecase/usecase.dart';

class PrintArticles implements Usecase<List<Article>>{
  final ArticlesRepository articlesRepository;

  PrintArticles({required this.articlesRepository});
  
  @override
  Future<List<Article>> call() async {
    List<Article> articles = await articlesRepository.getArticles();
    return articles;
  }

}