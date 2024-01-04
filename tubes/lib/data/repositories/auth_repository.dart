import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Userr?> signInWithEmailAndPassword(String email, String password);
  Future<Userr?> createUserWithEmailAndPassword(String name,String email, String password);
  Future<void> signOut();
  Future<Userr?> updateName(String newName);
  Future<Userr?> uploadProfilePicture();
  Future<void> addToBookMark(String id);
  // Stream<List<Article>> printBookMark();
}