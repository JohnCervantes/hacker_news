import 'package:flutter/material.dart';
import 'stories_blocs.dart';
export 'stories_blocs.dart';

class StoriesProvider extends InheritedWidget {
  // provider is use here to make the StoriesBloc bloc available to
  // other locations
  final StoriesBloc bloc;

  // boilderplate code
  // check udemy bloc lesson if needed to learn every code of this
  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  // updateshouldnotify should be set true
  // only touch this method if this is needed
  bool updateShouldNotify(_) => true;


  // more boilderplate code here
  // check udemy bloc lesson if needed to learn every code of this
  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
