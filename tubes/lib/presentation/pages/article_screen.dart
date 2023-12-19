import 'package:flutter/material.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  static const routeName = '/article';
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    print(article.id);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
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
                    color: Colors.black,
                    height: 1.25,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${article.author}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  article.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  const _NewsHeadline({
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageContainer(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          imageUrl: article.imageUrl,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
