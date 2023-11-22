import 'package:flutter/material.dart';
import 'package:tubes/presentation/pages/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
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
                  controller: name,
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
                  controller: email,
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
                  controller: password,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // try {
                    //   await _auth.createUserWithEmailAndPassword(
                    //       email: email.text, password: password.text);

                    //   // users.add({
                    //   //   'email': email.text,
                    //   //   'password': password.text,
                    //   // });
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const ToDoListPage(),
                    //     ),
                    //   );
                    // } catch (e) {
                    //   print(e);
                    // }
                    // email.text = '';
                    // password.text = '';

                    // ref.read(loginControllerProvider.notifier).login(email.text, password.text);
                    Navigator.pushNamed(context, HomeScreen.routeName);
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
