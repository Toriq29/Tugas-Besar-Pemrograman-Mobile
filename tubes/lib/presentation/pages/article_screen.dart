import 'package:flutter/material.dart';
import 'package:tubes/domain/entities/article_model.dart';
import 'package:tubes/presentation/widgets/custom_tag.dart';
import 'package:tubes/presentation/widgets/image_container.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  static const routeName = '/article';
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    print(article.id);
    return Scaffold(
      // backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          _NewsHeadline(
            article: article,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomTag(
                      backgroundColor: Colors.black,
                      children: [
                        const CircleAvatar(
                          radius: 10,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          article.author,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    CustomTag(
                      backgroundColor: Colors.grey.shade200,
                      children: const [
                        Icon(Icons.timer),
                        SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(width: 10),
                    CustomTag(
                      backgroundColor: Colors.grey.shade200,
                      children: [
                        const Icon(Icons.remove_red_eye),
                        const SizedBox(width: 10),
                        Text(
                          '${article.view}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '${article.body}',
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                CustomTag(
                  backgroundColor: Colors.grey.withAlpha(150),
                  children: [
                    Text(
                      article.category,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.25,
                      ),
                ),
              ],
            ),
          ),
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
