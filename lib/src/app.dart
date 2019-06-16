import 'package:flutter/material.dart';
import 'package:news/src/screens/about_screen.dart';
import 'package:news/src/screens/intro_screen.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  var seen = false;
  Widget build(context) {
    //wrap comments provider here
    return CommentsProvider(
        child:
            //wrap the stories provider here to use this provider
            StoriesProvider(
      child: MaterialApp(title: 'news', onGenerateRoute: routes),
    ));
  }

  Route routes(RouteSettings settings) {
//switch case sample
// switch(settings.name){
//   case '/': something()
// }
    if (settings.name == '/') {
      if (seen == false) {
        return MaterialPageRoute(builder: (context) {
          seen = true;
          return Intro();
        });
      } else {
        return MaterialPageRoute(builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        });
      }
    } else if (settings.name == '/about') {
      return MaterialPageRoute(builder: (context) {
        return About();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ' '));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetails(itemId: itemId);
      });
    }
  }
}
