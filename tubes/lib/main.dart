import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tubes/domain/usecase/app_theme.dart';
import 'package:tubes/firebase_options.dart';
import 'package:tubes/presentation/pages/edit_profile.dart';
import 'package:tubes/presentation/pages/login_screen.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/pages/register_screen.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'presentation/pages/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.grey,
      // ),
      initialRoute: '/',
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DiscoverScreen.routeName: (context) => const DiscoverScreen(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
      }
    );
  }
}