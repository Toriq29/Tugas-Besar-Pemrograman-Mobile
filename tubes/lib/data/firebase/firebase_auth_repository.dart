import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

      final DocumentSnapshot documentSnapshot =
          await users.doc(userCredential.user?.uid).get();

      if (userCredential.user != null) {
        final userData = documentSnapshot.data() as Map<String, dynamic>;

        return Userr(
          uid: userCredential.user?.uid,
          email: userCredential.user?.email,
          name: userData['name'],
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
      );
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  @override
  Future<Userr?> updateName(String newName) async {
    try {
      User? user = _firebaseAuth.currentUser;

      await users.doc(user?.uid).set({"name": newName});
      return Userr(uid: user?.uid, name: newName, email: user?.email);

    } catch (error) {
      print('Error updating email: $error');
    }
    return null;
  }

  @override
  Future<Userr?> uploadProfilePicture(Userr userr) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    User? user = _firebaseAuth.currentUser;

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('profile');

    Reference referenceImageToUpload = referenceDirImage.child(user!.uid);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      user.updatePhotoURL(await referenceImageToUpload.getDownloadURL());
      return Userr(
          uid: userr.uid,
          name: userr.name,
          email: userr.email);
    } catch (e) {
      print("error upload image : ${e}");
      return userr;
    }
  }
}
