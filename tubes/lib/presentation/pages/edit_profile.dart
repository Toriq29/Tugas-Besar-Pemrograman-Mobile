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
                const SizedBox(height: 70),
                if (ref.read(loginRegisterProvider).user!.photoUrl != "")
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        ref.read(loginRegisterProvider).user!.photoUrl),
                  )
                else
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("lib/data/images/profile.png"),
                  ),
                const SizedBox(height: 10),
                Container(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(loginRegisterProvider.notifier)
                          .uploadProfile();
                
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
                ),
                const SizedBox(height: 80),
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
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () async {
                      // ignore: unnecessary_null_comparison
                      if (nameController != null) {
                        String newName = nameController.text.trim();
                
                        if (newName.isNotEmpty) {
                          await ref
                              .read(loginRegisterProvider.notifier)
                              .updateName(newName);
                
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Masukkan nama'),
                          ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: Colors.black),
                    child: const Text(
                      "Edit Nama",
                      style: TextStyle(color: Colors.white),
                    ),
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
