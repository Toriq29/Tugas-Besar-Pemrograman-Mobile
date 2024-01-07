import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/data/firebase/firebase_auth_repository.dart';
import 'package:tubes/data/repositories/auth_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/domain/entities/user.dart';

class AuthState {
  final Userr? user;

  AuthState({required this.user});
}

class LoginAndRegister extends StateNotifier<AuthState> {
  final AuthRepository _authRepository = FirebaseAuthRepository();
  final Ref ref;

  LoginAndRegister(this.ref) : super(AuthState(user: null));

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final Userr? user =
        await _authRepository.signInWithEmailAndPassword(email, password);
    state = AuthState(user: user);
  }

  Future<void> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    final Userr? user = await _authRepository.createUserWithEmailAndPassword(
        name, email, password);
    state = AuthState(user: user);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = AuthState(user: null);
  }

  Future<void> updateName(String newName) async {
    final Userr? user = await _authRepository.updateName(newName, state.user!);
    state = AuthState(user: user);
  }

  Future<void> uploadProfile() async {
    final Userr? user = await _authRepository.uploadProfilePicture(state.user!);
    state = AuthState(user: user);
  }

  List<Article> getBookMark(List<Article> listArticle)  {
    final List<Article> articleList =  _authRepository.getBookMarkStream(listArticle, state.user!);
    return articleList;
  }


  Future<void> addBookMark(String id) async {
    final Userr? user = await _authRepository.addToBookMark(id, state.user!);
    state = AuthState(user: user);
  }

  Future<void> removeBookMark(String id) async {
    final Userr? user = await _authRepository.removeToBookMark(id, state.user!);
    state = AuthState(user: user);
  }

  bool checkBookmark(String idArticle){
    bool ckeck = _authRepository.checkingBookmark(idArticle, state.user!);
    return ckeck;
  }
}
