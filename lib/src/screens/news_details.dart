import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/comments_provider.dart';
import '../widgets/comment.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  Widget build(context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text('News Details', style: TextStyle(color: Colors.white))),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemsWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('loading');
        }

        final futureItem = snapshot.data[itemId];

        return FutureBuilder(
          future: futureItem,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                color: Colors.black,
                child: buildList(snapshot.data, itemSnapshot.data));
          },
        );
      },
    );
  }

  Widget buildList(Map<int, Future<ItemModel>> itemMap, ItemModel item) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId) {
      return Comment(
        id: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();
    children.addAll(commentsList);

    return ListView(children: children);
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.grey[800],
      alignment: Alignment.topCenter,
      child: ListTile(
        onTap: () {
          launch(item.url);
        },
        title: Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        subtitle: item.url != null
            ? Text(
                '(${item.url})',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue[300],
                ),
                textAlign: TextAlign.center,
              )
            : Text(''),
      ),
    );
  }
}
