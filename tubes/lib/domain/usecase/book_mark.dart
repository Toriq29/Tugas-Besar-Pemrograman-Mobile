import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/data/firebase/firebase_auth_repository.dart';
import 'package:tubes/data/repositories/auth_repository.dart';
import 'package:tubes/domain/entities/article_model.dart';

class BookMark{
  final AuthRepository _authRepository = FirebaseAuthRepository();
  Future<void> addBookMark(String id) async{
    return await _authRepository.addToBookMark(id);
  }

}