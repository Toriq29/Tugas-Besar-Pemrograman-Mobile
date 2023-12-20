import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tubes/presentation/pages/discover_screen.dart';
import 'package:tubes/presentation/pages/home_screen.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
class BottomNavBar extends HookConsumerWidget {
  const BottomNavBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: appThemeState.isDarkModeEnabled ? Colors.black : Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black,
      unselectedItemColor: appThemeState.isDarkModeEnabled ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100),
      items: [
         BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(left: 50),
                child: IconButton( 
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }, 
                  icon: const Icon(Icons.home))), 
              label: 'Home'),

         BottomNavigationBarItem(
              icon: IconButton( 
                onPressed: () {
                  Navigator.pushNamed(context, DiscoverScreen.routeName);
                }, 
                icon: const Icon(Icons.newspaper)), 
              label: 'Search'),

         BottomNavigationBarItem( 
              icon: Container(
                margin: const EdgeInsets.only(right: 50),
                child: IconButton( 
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  }, 
                  icon: const Icon(Icons.person))), 
              label: 'Profile'),
      ],
    );
  }
}