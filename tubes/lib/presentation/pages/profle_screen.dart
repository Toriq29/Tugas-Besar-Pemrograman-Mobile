import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/edit_profile.dart';
// import 'package:tubes/presentation/pages/edit_profile.dart';
import 'package:tubes/presentation/pages/login_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/widgets/bottom_nav_bar.dart';
import 'package:tubes/presentation/widgets/custom_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomHeader(),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (ref.read(loginRegisterProvider).user!.photoUrl != "")
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      ref.read(loginRegisterProvider).user!.photoUrl),
                )
              else
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("lib/data/images/profile.png"),
                ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Text(ref.read(loginRegisterProvider).user!.name,
                      style: const TextStyle(fontSize: 20)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditProfileScreen.routeName);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(loginRegisterProvider.notifier).signOut();
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage("lib/data/images/logout.png"),
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 30),
                      Text("Log Out")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
