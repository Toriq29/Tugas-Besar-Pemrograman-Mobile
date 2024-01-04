import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/article_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/theme_provider.dart';
import 'package:tubes/presentation/widgets/bottom_nav_bar.dart';
import 'package:tubes/presentation/widgets/custom_header.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Nasional',
      'Internasional',
      'Ekonomi',
      'Olahraga',
      'Otomotif'
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: const CustomHeader(),
        bottomNavigationBar: const BottomNavBar(index: 1),
        body: Column(
          children: [
            _CategoryNews(tabs: tabs),
          ],
        ),
      ),
    );
  }
}

class _CategoryNews extends ConsumerStatefulWidget {
  const _CategoryNews({
    required this.tabs,
  });

  final List<String> tabs;

  @override
  ConsumerState<_CategoryNews> createState() => __CategoryNewsState();
}

class __CategoryNewsState extends ConsumerState<_CategoryNews> {
  @override
  Widget build(BuildContext context) {
    final articlesAsyncValue = ref.watch(articleProvider);
    final appThemeState = ref.watch(appThemeStateNotifier);
    return articlesAsyncValue.when(
        data: (articles) {
          return Column(
            children: [
              TabBar(
                isScrollable: true,
                indicatorColor: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black,
                tabs: widget.tabs
                    .map(
                      (e) => Tab(
                        icon: Text(
                          e,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold, color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  children: widget.tabs
                      .map(
                        (e) => ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            if (e == articles[index].category) {
                              return InkWell(
                                onTap: () async {
                                  Navigator.pushNamed(
                                    context,
                                    ArticleScreen.routeName,
                                    arguments: articles[index],
                                  );

                                  ref.read(incrementViewProvider(
                                      articles[index].id));

                                  setState(() {
                                    articles[index].view += 1;
                                  });
                                },
                                child: Row(
                                  children: [
                                    ImageContainer(
                                        width: 80,
                                        height: 100,
                                        borderRadius: 5,
                                        margin: const EdgeInsets.all(10),
                                        imageUrl: articles[index].imageUrl),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            articles[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold, color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              
                                              Icon(
                                                Icons.visibility,
                                                size: 18,
                                                color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                  '${articles[index].view} views', style: TextStyle(color: appThemeState.isDarkModeEnabled ? Colors.white : Colors.black),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class _DiscoverNews extends StatelessWidget {
  const _DiscoverNews();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Discover",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            'News from all over the world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
