import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/pages/article_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'package:tubes/presentation/widgets/bottom_nav_bar.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsyncValue = ref.watch(articleProvider);
    return articlesAsyncValue.when(
        data: (articles) {
          return Scaffold(
            bottomNavigationBar: const BottomNavBar(index: 0),
            extendBodyBehindAppBar: true,
            body: ListView(padding: EdgeInsets.zero, children: [
              _NewsOfTheDay(article: articles[0]),
              _BreakingNews(articles: ref.read(breakingNewsProvider(articles))),
            ]),
          );
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class _BreakingNews extends ConsumerStatefulWidget {
  const _BreakingNews({
    required this.articles,
  });

  final List<Article> articles;
  @override
  ConsumerState<_BreakingNews> createState() => __BreakingNewsState();
}

class __BreakingNewsState extends ConsumerState<_BreakingNews> {
  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Berita Terkini",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appThemeState.isDarkModeEnabled
                          ? Colors.white
                          : Colors.black),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                ),
                Text(
                  "Selengkapnya",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: appThemeState.isDarkModeEnabled
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.articles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ArticleScreen.routeName,
                          arguments: widget.articles[index],
                        );
                        ref.read(
                            incrementViewProvider(widget.articles[index].id));
                        widget.articles[index].view += 1;

                        setState(() {});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageContainer(
                            width: MediaQuery.of(context).size.width * 0.6,
                            imageUrl: widget.articles[index].imageUrl,
                            borderRadius: 10,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.articles[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
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
                                '${widget.articles[index].view} views',
                                style: TextStyle(
                                    color: appThemeState.isDarkModeEnabled
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                          Text('by ${widget.articles[index].author}',
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: appThemeState.isDarkModeEnabled
                                          ? Colors.white
                                          : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _NewsOfTheDay extends ConsumerWidget {
  const _NewsOfTheDay({
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ImageContainer(
      borderRadius: 0,
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      imageUrl: article.imageUrl,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 20, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Berita terbaik hari ini",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ArticleScreen.routeName,
                  arguments: article,
                );

                ref.read(incrementViewProvider(article.id));
                article.view += 1;
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Baca selengkapnya",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
