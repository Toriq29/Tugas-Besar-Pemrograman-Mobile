import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/pages/article_screen.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class BookMarkScreen extends ConsumerStatefulWidget {
  const BookMarkScreen({super.key});

  static const routeName = '/bookmark';

  @override
  ConsumerState<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends ConsumerState<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    final articles =
        ModalRoute.of(context)!.settings.arguments as List<Article>;
    final bookmark =
        ref.read(loginRegisterProvider.notifier).getBookMark(articles);
    var appThemeState = ref.read(appThemeStateNotifier);
    print(bookmark);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Mark"),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: ListView.builder(
        itemCount: bookmark.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              Navigator.pushNamed(
                context,
                ArticleScreen.routeName,
                arguments: bookmark[index],
              );
      
              ref.read(incrementViewProvider(bookmark[index].id));
      
              setState(() {
                bookmark[index].view += 1;
              });
            },
            child: Row(
              children: [
                ImageContainer(
                    width: 80,
                    height: 100,
                    borderRadius: 5,
                    margin: const EdgeInsets.all(10),
                    imageUrl: bookmark[index].imageUrl),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bookmark[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: appThemeState.isDarkModeEnabled
                                    ? Colors.white
                                    : Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 18,
                            color: appThemeState.isDarkModeEnabled
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${bookmark[index].view} views',
                            style: TextStyle(
                                color: appThemeState.isDarkModeEnabled
                                    ? Colors.white
                                    : Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
