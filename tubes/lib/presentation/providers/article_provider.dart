import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/domain/usecase/print_articles.dart';
import 'package:tubes/presentation/providers/article_repository_provider.dart';

final articleProvider = FutureProvider<List<Article>>((ref) async {
  final List<Article> listArticles = await PrintArticles(
          articlesRepository: ref.read(articlesRepositoryProvider))
      .call();
  return listArticles;
});

final incrementViewProvider =
    FutureProvider.autoDispose.family<String, String>((ref, articleId) async {
  await PrintArticles(articlesRepository: ref.read(articlesRepositoryProvider))
      .incrementViews(articleId);
  return '';
});

final breakingNewsProvider = Provider.autoDispose
    .family<List<Article>, List<Article>>((ref, articles) {
  List<Article> breakingNews = [];

  for (var i = 1; i < 5; i++) {
    breakingNews.add(articles[i]);
  }

  return breakingNews;
});
