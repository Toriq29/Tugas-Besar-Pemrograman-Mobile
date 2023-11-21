import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tubes/data/firebase/firebase_articles_repository.dart';
import 'package:tubes/data/repositories/articles_repository.dart';

part 'article_repository_provider.g.dart';

@riverpod
ArticlesRepository articlesRepository(ArticlesRepositoryRef ref) => FirebaseArticlesRepository();