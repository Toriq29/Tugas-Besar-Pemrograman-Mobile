import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/user.dart';
import 'package:tubes/presentation/pages/home_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const routeName = '/register';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Image(
                  image: AssetImage("lib/data/images/news.png"),
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
                const Text(
                  "NewsWaves",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "Masukkan nama",
                  ),
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "Masukkan email",
                  ),
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "Masukkan password",
                  ),
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // ignore: unnecessary_null_comparison
                    if (nameController != null &&emailController != null && passwordController != null) {
                      String regName = nameController.text.trim();
                      String regEmail = emailController.text.trim();
                      String regPass = passwordController.text.trim();
                      if (regName.isNotEmpty || regEmail.isNotEmpty || regPass.isNotEmpty) {
                        if (regName.isNotEmpty) {
                          if (regEmail.isNotEmpty) {
                            if (regPass.isNotEmpty) {
                              await ref
                                  .read(loginRegisterProvider.notifier)
                                  .createUserWithEmailAndPassword(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);
                              Userr? user =
                                  ref.read(loginRegisterProvider).user;
                              if (user != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Email tidak sesuai'),
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Silahkan masukkan password'),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Silahkan masukkan email'),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Silahkan masukkan nama'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Silahkan masukkan nama, email, dan password'),
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: Colors.black),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
