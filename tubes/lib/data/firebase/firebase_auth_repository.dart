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
          photoUrl: userData['photoUrl'],
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

      final DocumentSnapshot documentSnapshot =
          await users.doc(user?.uid).get();
      final userData = documentSnapshot.data() as Map<String, dynamic>;

      await users
          .doc(user?.uid)
          .set({"name": newName, "photoUrl": userData['photoUrl']});

      return Userr(
        uid: user?.uid,
        name: newName,
        email: user?.email,
        photoUrl: userData['photoUrl'],
      );
    } catch (error) {
      print('Error updating email: $error');
    }
    return null;
  }

  @override
  Future<Userr?> uploadProfilePicture() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    User? user = _firebaseAuth.currentUser;

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('profile');
    Reference referenceImageToUpload = referenceDirImage.child(user!.uid);

    // Upload the image to Firebase Storage
    await referenceImageToUpload.putFile(File(file!.path));

    // Get the download URL for the uploaded image
    final photoUrl = await referenceImageToUpload.getDownloadURL();

    // Update the user document with the new photoUrl
    await users.doc(user.uid).update({"photoUrl": photoUrl});

    final DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();
    final userData = documentSnapshot.data() as Map<String, dynamic>;

    // Return the updated user object
    return Userr(
      uid: user.uid,
      name: userData['name'], // Make sure userData is defined
      email: user.email,
      photoUrl: userData['photoUrl'],
    );
    
  }
}
