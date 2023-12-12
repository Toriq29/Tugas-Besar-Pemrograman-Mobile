import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/data/firebase/firebase_auth_repository.dart';
import 'package:tubes/data/repositories/auth_repository.dart';
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
    final Userr? user = await _authRepository.updateName(newName);
    state = AuthState(user: user);
  }

  Future<void> uploadProfile() async {
    final Userr? user = await _authRepository.uploadProfilePicture();
    state = AuthState(user: user);
  }
}
