import 'package:firebase_auth/firebase_auth.dart';

class Userr{
  final String? uid;
  final String name;
  final String? email;
  final UserCredential password;

  Userr({required this.uid, required this.name, required this.email, required this.password});
  
}