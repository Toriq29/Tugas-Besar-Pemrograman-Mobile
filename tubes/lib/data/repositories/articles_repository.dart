import 'package:tubes/domain/entities/article_model.dart';

abstract interface class ArticlesRepository{
  Future<List<Article>> getArticles();
}