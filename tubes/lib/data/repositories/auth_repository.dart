import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Userr?> signInWithEmailAndPassword(String email, String password);
  Future<Userr?> createUserWithEmailAndPassword(String name,String email, String password);
  Future<void> signOut();
  Future<Userr?> updateName(String newName, Userr user);
  Future<Userr?> uploadProfilePicture(Userr user);
  Future<Userr?> addToBookMark(String id, Userr user);
  Future<Userr?> removeToBookMark(String id, Userr user);
  List<Article> getBookMarkStream(List<Article> listArticle, Userr user);
  bool checkingBookmark(String idArticle, Userr user);
}