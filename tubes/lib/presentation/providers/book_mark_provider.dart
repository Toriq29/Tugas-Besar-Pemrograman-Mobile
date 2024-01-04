import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/usecase/book_mark.dart';

final bookMarkProvider = FutureProvider.autoDispose.family<String, String>((ref, articleId) async {
  await BookMark().addBookMark(articleId);
  return "";
});