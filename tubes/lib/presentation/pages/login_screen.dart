import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/user.dart';
import 'package:tubes/presentation/pages/home_screen.dart';
import 'package:tubes/presentation/pages/register_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  static const routeName = '/';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    if (emailController != null && passwordController != null) {
                      String loginEmail = emailController.text.trim();
                      String loginPass = passwordController.text.trim();
                      if (loginEmail.isNotEmpty || loginPass.isNotEmpty) {
                        if (loginEmail.isNotEmpty) {
                          if (loginPass.isNotEmpty) {
                            await ref
                                .read(loginRegisterProvider.notifier)
                                .signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);

                            Userr? user = ref.read(loginRegisterProvider).user;
                            if (user != null) {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Email atau password salah'),
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
                          content: Text('Silahkan masukkan email dan password'),
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: Colors.black),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text(
                        " SignUp",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
