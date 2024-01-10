import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = '/edit_profile';

  

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color:
                  appThemeState.isDarkModeEnabled ? Colors.white : Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
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
                      setState(() {
                        
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: appThemeState.isDarkModeEnabled
                            ? Colors.white
                            : Colors.black),
                    child: Text(
                      "Edit Photo Profile",
                      style: TextStyle(
                          color: appThemeState.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                TextField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hintText: "Masukkan nama baru",
                  ),
                  controller: nameController,
                  cursorColor: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black,
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
                        backgroundColor: appThemeState.isDarkModeEnabled
                            ? Colors.white
                            : Colors.black),
                    child: Text(
                      "Edit Nama",
                      style: TextStyle(
                          color: appThemeState.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white),
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
