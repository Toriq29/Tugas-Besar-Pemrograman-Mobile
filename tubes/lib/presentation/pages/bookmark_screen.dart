import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/presentation/pages/article_screen.dart';
import 'package:tubes/presentation/pages/profle_screen.dart';
import 'package:tubes/presentation/providers/article_provider.dart';
import 'package:tubes/presentation/providers/book_mark_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Mark"),
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
      // body: ref.read(getBookMarkProvider).when(
      //       data: (articles) {
      //         setState(() {
                
      //         });
      //         return ListView.builder(
      //             itemCount: articles.length,
      //             itemBuilder: (context, index) {
      //               var appThemeState = ref.read(appThemeStateNotifier);
      //               return InkWell(
      //                 onTap: () async {
      //                   Navigator.pushNamed(
      //                     context,
      //                     ArticleScreen.routeName,
      //                     arguments: articles[index],
      //                   );

      //                   ref.read(incrementViewProvider(articles[index].id));

      //                   setState(() {
      //                     articles[index].view += 1;
      //                   });
      //                 },
      //                 child: Row(
      //                   children: [
      //                     ImageContainer(
      //                         width: 80,
      //                         height: 100,
      //                         borderRadius: 5,
      //                         margin: const EdgeInsets.all(10),
      //                         imageUrl: articles[index].imageUrl),
      //                     Expanded(
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Text(
      //                             articles[index].title,
      //                             style: Theme.of(context)
      //                                 .textTheme
      //                                 .bodyLarge!
      //                                 .copyWith(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: appThemeState.isDarkModeEnabled
      //                                         ? Colors.white
      //                                         : Colors.black),
      //                           ),
      //                           const SizedBox(height: 5),
      //                           Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.visibility,
      //                                 size: 18,
      //                                 color: appThemeState.isDarkModeEnabled
      //                                     ? Colors.white
      //                                     : Colors.black,
      //                               ),
      //                               const SizedBox(width: 5),
      //                               Text(
      //                                 '${articles[index].view} views',
      //                                 style: TextStyle(
      //                                     color: appThemeState.isDarkModeEnabled
      //                                         ? Colors.white
      //                                         : Colors.black),
      //                               )
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             });
      //       },
      //       error: (error, stackTrace) => Text('Error: $error'),
      //       loading: () => const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     ),
    );
  }
}
