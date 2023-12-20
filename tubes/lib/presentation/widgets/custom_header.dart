import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';

class CustomHeader extends ConsumerWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return AppBar(
      title: Text(
        "NewsWaves",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.bold, color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: Image(
          image: appThemeState.isDarkModeEnabled ? const AssetImage("lib/data/images/news_white.png") : const AssetImage("lib/data/images/news.png"),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
