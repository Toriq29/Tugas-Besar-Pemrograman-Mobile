import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';

class EditProfileScreen extends ConsumerWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  static const routeName = '/edit_profile';

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
                    hintText: "Masukkan nama baru",
                  ),
                  controller: nameController,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(loginRegisterProvider.notifier).updateName(nameController.text);

                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: Colors.black),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    await ref.read(loginRegisterProvider.notifier).uploadProfile();

                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: Colors.black),
                  child: const Text(
                    "Edit Photo Profile",
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
