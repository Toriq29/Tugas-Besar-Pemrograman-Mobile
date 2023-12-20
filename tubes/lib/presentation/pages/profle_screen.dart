import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/edit_profile.dart';
import 'package:tubes/presentation/pages/login_screen.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'package:tubes/presentation/widgets/bottom_nav_bar.dart';
import 'package:tubes/presentation/widgets/custom_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
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
                      style: TextStyle(fontSize: 20, color:appThemeState.isDarkModeEnabled ? Colors.white : Colors.black )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditProfileScreen.routeName);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),
                    child: Text(
                      "Update Profile",
                      style: TextStyle(color: appThemeState.isDarkModeEnabled ? Colors.black : Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(loginRegisterProvider.notifier).signOut();
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child:  Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode)),
                          const SizedBox(width: 5),
                          Text("Dark Mode",
                          style: TextStyle(color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.35),
              Switch(
                  value: appThemeState.isDarkModeEnabled,
                  onChanged: (enabled) {
                    if (enabled) {
                      appThemeState.setDarkTheme();
                    } else {
                      appThemeState.setLightTheme();
                    }
                  }),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.43),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(loginRegisterProvider.notifier).signOut();
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
                      const SizedBox(width: 5),
                      Text("Log Out", style: TextStyle(color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),)
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
