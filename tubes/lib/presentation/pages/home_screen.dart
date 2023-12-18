import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/pages/article_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/login_register_provider.dart';
import 'package:tubes/presentation/widgets/bottom_nav_bar.dart';
import 'package:tubes/presentation/widgets/custom_tag.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(loginRegisterProvider).user?.name);
    final articlesAsyncValue = ref.watch(articleProvider);
    return articlesAsyncValue.when(
        data: (article) {
          return Scaffold(
            bottomNavigationBar: const BottomNavBar(index: 0),
            extendBodyBehindAppBar: true,
            body: ListView(padding: EdgeInsets.zero, children: [
              _NewsOfTheDay(article: article[article.length - 1]),
              _BreakingNews(articles: article),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Berita Terkini",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Selengkapnya",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.articles.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(right: 10),
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

                      setState(() {
                        
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                          width: MediaQuery.of(context).size.width * 0.5,
                          imageUrl: widget.articles[index].imageUrl,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.articles[index].title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, height: 1.5),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text('${widget.articles[index].view} views'),
                          ],
                        ),
                        Text('by ${widget.articles[index].author}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
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

class _NewsOfTheDay extends StatelessWidget {
  const _NewsOfTheDay({
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      imageUrl: article.imageUrl,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(backgroundColor: Colors.grey.withAlpha(150), children: [
              Text(
                "Berita terbaik hari ini",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ]),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Colors.white),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Row(
                children: [
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
