import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tubes/domain/entities/article_model.dart';
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

      final QuerySnapshot<Map<String, dynamic>> documents = await users
          .doc(userCredential.user?.uid)
          .collection("bookMark")
          .get();
      List<String> bookMarks = [];
      try {
        for (var document in documents.docs) {
          bookMarks.add(document.data()['id_article']);
        }
      } catch (e) {
        print(e);
      }

      print(bookMarks);

      if (userCredential.user != null) {
        final userData = documentSnapshot.data() as Map<String, dynamic>;

        return Userr(
          uid: userCredential.user?.uid,
          email: userCredential.user?.email,
          name: userData['name'],
          photoUrl: userData['photoUrl'],
          bookMark: bookMarks,
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
        "photoUrl": "",
      });

      return Userr(
        uid: userCredential.user?.uid,
        name: name,
        email: email,
        photoUrl: "",
        bookMark: [],
      );
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  @override
  Future<Userr?> updateName(String newName, Userr user) async {
    try {
      final DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();
      final userData = documentSnapshot.data() as Map<String, dynamic>;

      await users.doc(user.uid).update({"name": newName});

      return Userr(
        uid: user.uid,
        name: newName,
        email: user.email,
        photoUrl: userData['photoUrl'],
        bookMark: user.bookMark,
      );
    } catch (error) {
      print('Error updating email: $error');
    }
    return null;
  }

  @override
  Future<Userr?> uploadProfilePicture(Userr user) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    ImageCropper imageCropper = ImageCropper();

    CroppedFile? croppedFile = await imageCropper.cropImage(
      sourcePath: file!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      maxHeight: 512,
      maxWidth: 512,
    );

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('profile');
    Reference referenceImageToUpload = referenceDirImage.child(user.uid!);

    await referenceImageToUpload.putFile(File(croppedFile!.path));

    final photoUrl = await referenceImageToUpload.getDownloadURL();

    await users.doc(user.uid).update({"photoUrl": photoUrl});

    final DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();
    final userData = documentSnapshot.data() as Map<String, dynamic>;

    return Userr(
      uid: user.uid,
      name: userData['name'],
      email: user.email,
      photoUrl: userData['photoUrl'],
      bookMark: user.bookMark,
    );
  }

  @override
  Future<Userr?> addToBookMark(String id, Userr user) async {
    try {
      await users.doc(user.uid).collection("bookMark").add({"id_article": id});

      user.bookMark.add(id);

      return Userr(
        uid: user.uid,
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        bookMark: user.bookMark,
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<Userr?> removeToBookMark(String id, Userr user) async {
    try {
    final collectionReference = users.doc(user.uid).collection("bookMark");

    final querySnapshot = await collectionReference.where('id_article', isEqualTo: id).get();

    final documentReference = querySnapshot.docs.first.reference;
    await documentReference.delete();

    user.bookMark.remove(id);

      return Userr(
        uid: user.uid,
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        bookMark: user.bookMark,
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  List<Article> getBookMarkStream(listArticle, Userr user) {
    List<Article> bookMarkArticle = [];
    for (var bookMarkId in user.bookMark) {
      for (var article in listArticle) {
        if (bookMarkId == article.id) {
          bookMarkArticle.add(article);
        }
      }
    }
    return bookMarkArticle;
  }

  @override
  bool checkingBookmark(String idArticle, Userr user) {
    bool checking = false;

    for (var idBookmark in user.bookMark) {
      if (idBookmark == idArticle) {
        checking = true;
        break;
      }
    }

    return checking;
  }
  
  
}


