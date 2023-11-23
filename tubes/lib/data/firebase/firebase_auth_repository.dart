import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tubes/data/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<Userr?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final userData =
            users.doc(userCredential.user?.uid) as Map<String, dynamic>;
        return Userr(
          uid: userCredential.user?.uid,
          email: userCredential.user?.email,
          name: userData['name'],
          password: userCredential,
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Userr?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      users.doc(userCredential.user?.uid).set({
        "name": name,
      });

      return Userr(
          uid: userCredential.user?.uid,
          name: name,
          email: email,
          password: userCredential);
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }
}
