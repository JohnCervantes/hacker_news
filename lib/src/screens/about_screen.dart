import 'package:flutter/material.dart';

class About extends StatelessWidget {
  Widget build(context) {
    return aboutDetails();
  }

  Widget aboutDetails() {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
          backgroundColor: Colors.green[400],
        ),
        body: Container(
          color: Colors.black,
          child: ListView(children: <Widget>[
            Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: 400.0,
                      height: 150.0,
                      child: Image.asset(
                        'assets/hackernews.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(20.0),
                        child: RichText(
                            text: TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: ('Hacker News '),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    fontSize: 16.0)),
                            TextSpan(
                                text:
                                    ("""is a reddit-like website run by Y Combinator. YC (as Y Combinator is often referred to) is one of the most prominent startup incubators in Silicon Valley. Users can submit posts, which often include interesting news articles, new product announcements, and in general"""),
                                style: TextStyle(height: 1.5, fontSize: 16.0)),
                            TextSpan(
                              text:
                                  (' “anything that gratifies one’s intellectual curiosity”.'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                  fontSize: 16.0),
                            )
                          ],
                        ))),
                    Divider(
                      color: Colors.redAccent,
                    ),
                    Text(
                      """developed by: Bad Seal Studios\nversion: 1.0""",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, height: 1.5, fontSize: 16.0),
                    ),
                    Container(
                      width: 75.0,
                      height: 75.0,
                      child: Image.asset(
                        'assets/sealNoText.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }
}
