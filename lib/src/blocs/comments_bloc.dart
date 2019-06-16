import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBloc {
  final repository = Repository();
  final commentsFetcher = PublishSubject<int>();
  final commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

//stream
  Observable<Map<int, Future<ItemModel>>> get itemsWithComments =>
      commentsOutput.stream;
//sink
  Function(int) get fetchItemWithComments => commentsFetcher.sink.add;

  CommentsBloc() {
    commentsFetcher.stream
        .transform(commentsTransformer())
        .pipe(commentsOutput);
  }

  commentsTransformer() {
    //reccursion happened here to get the sub c omments
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
      cache[id] = repository.fetchItem(id);
      cache[id].then((ItemModel item) {
        item.kids.forEach((kid) => fetchItemWithComments(kid));
      });
      return cache;

      
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    commentsFetcher.close();
    commentsOutput.close();
  }
}
