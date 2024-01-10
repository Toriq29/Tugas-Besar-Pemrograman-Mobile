import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/pages/bookmark_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'package:tubes/presentation/widgets/image_container.dart';


class ArticleBookMarkScreen extends ConsumerStatefulWidget {
  const ArticleBookMarkScreen({super.key});

  static const routeName = '/article_bookmark';
  @override
  ConsumerState<ArticleBookMarkScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleBookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NewsHeadline(
              article: article,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 1),
              child: Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appThemeState.isDarkModeEnabled
                          ? Colors.white
                          : Colors.black,
                      height: 1.25,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${article.author}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: appThemeState.isDarkModeEnabled
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    article.body,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: appThemeState.isDarkModeEnabled
                            ? Colors.white
                            : Colors.black),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _NewsHeadline extends ConsumerStatefulWidget {
  const _NewsHeadline({required this.article});

  final Article article;

  @override
  ConsumerState<_NewsHeadline> createState() => __NewsHeadlineState();
}

class __NewsHeadlineState extends ConsumerState<_NewsHeadline> {
  @override
  Widget build(BuildContext context) {
    var checkBookmark =
        ref.watch(loginRegisterProvider.notifier).checkBookmark(widget.article.id);
    return Stack(
      children: [
        ImageContainer(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          imageUrl: widget.article.imageUrl,
          borderRadius: 0,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5,),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8)
              ),
              child: IconButton(
                  onPressed: () {
                    ref.watch(articleProvider).when(
                              data: (articles) {
                                Navigator.pushNamed(
                                    context, BookMarkScreen.routeName,
                                    arguments: articles);
                              },
                              error: (error, stackTrace) => Text('Error: $error'),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new,)),
            ),
          ),
          actions: [
            if (checkBookmark == true)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                      onPressed: () async {
                         await ref.watch(loginRegisterProvider.notifier).removeBookMark(widget.article.id);
                         setState(() {
                           
                         });
                      },
                      icon: const Icon(Icons.bookmark_added_rounded,)),
                ),
              ),
            if (checkBookmark == false)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: IconButton(
                      onPressed: () async {
                        await ref
                            .watch(loginRegisterProvider.notifier).addBookMark(widget.article.id);
                        setState(() {
                          
                        });
                      },
                      icon: const Icon(Icons.bookmark_add_outlined,)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}