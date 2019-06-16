import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_screen.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }

              return buildTile(context, itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        decoration: new BoxDecoration(color: Colors.grey[700]),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/$itemId');
          },
          title: Text(item.title,
              style:
                  TextStyle(color: Colors.white, height: 1.2, fontSize: 16.0)),
          subtitle: Row(children: [
            Icon(Icons.thumbs_up_down),
            Text(
              '  ${item.score} points',
              style: TextStyle(color: Colors.white),
            )
          ]),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text(
                '${item.descendants}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      Divider(
          // height: 8.0,
          ),
    ]);
  }
}
