import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  ScrollController controller = new ScrollController();

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green[400],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward), title: Text('Scroll top')),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), title: Text('About')),
        ],
        onTap: (int index) {
          if (index == 0) {
            controller.animateTo(0,
                curve: Curves.linear, duration: Duration(milliseconds: 500));
          } else {
            Navigator.pushNamed(context, '/about');
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Hacker News', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              bloc.clearCache();
              bloc.fetchTopIds();
              NewsList();
            },
          )
        ],
      ),
      body: Container(color: Colors.black, child: buildList(bloc)),
    );
  }

  //We have access to storiesbloc because storiesbloc
  //is exported to stories provider class
  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      //its a good practice to tell whih type of data is the snapshot
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          //basic loading animation
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
            child: ListView.builder(
          controller: controller,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            bloc.fetchItem(snapshot.data[index]);
            //when creating an instance of a class
            // you also need to write the variable name like itemId below
            return NewsListTile(itemId: snapshot.data[index]);
          },
        ));
      },
    );
  }
}
