import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildGreyContainer(),
          subtitle: buildGreyContainer(),
        ),
        Divider(),
      ],
    );
  }

  Widget buildGreyContainer() {
    return Container(
      color: Colors.grey,
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
