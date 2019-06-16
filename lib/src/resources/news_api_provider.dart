import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'repository.dart';

final root = 'https://hacker-news.firebaseio.com/v0';


class NewsApiProvider implements Source {
  Client client = Client();

   Future<List<int>> fetchTopIds() async {
    final response = await client.get('$root/topstories.json');
    final ids = json.decode(response.body);
    //to solve the List<dynamic> error use CAST
    return ids.cast<int>(); 
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
