import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'package:html_unescape/html_unescape.dart';
import 'loading_screen.dart';

class Comment extends StatelessWidget {
  final int id;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.id, this.itemMap, this.depth});

  Widget build(context) {
    return FutureBuilder(
        future: itemMap[id],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          final children = <Widget>[
            Container(
                margin: EdgeInsets.only(
                    left: (depth * 15).toDouble(),
                    right: (depth * 15).toDouble(),
                    top: 5.0),
                color: Colors.grey[700],
                child: ListTile(
                  title: buildText(snapshot.data),
                  subtitle: snapshot.data.by == ''
                      ? Text(
                          'This comment has been deleted.',
                          style: TextStyle(color: Colors.white, height: 1.5, fontSize: 16.0),
                          textAlign: TextAlign.center
                        )
                      : Text(
                          '-${snapshot.data.by}',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                  contentPadding: EdgeInsets.only(
                    right: 16.0,
                    left: depth * 16.0,
                  ),
                )),
          ];

          snapshot.data.kids.forEach((kidId) {
            children.add(
              Comment(
                id: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          });

          return Column(children: children);
        });
  }

  Widget buildText(ItemModel item) {
    var unescape = new HtmlUnescape();
    var text = unescape.convert(item.text);
    return Text(
      text,
      style: TextStyle(color: Colors.white, height: 1.5, fontSize: 16.0),
    );
  }
}
