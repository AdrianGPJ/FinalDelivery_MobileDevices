import 'dart:convert';

import 'package:http/http.dart' as http;

class Gif {
  String name;
  String url;

  Gif.fromJson(json)
      : name = json["title"],
        url = json["media_formats"]["nanogif"]["url"];
}

Future<List<Gif>> loadTenorGifs(String searchTerm, int limit) async {
  final apiKey =
      "AIzaSyAX3gTNScKbmNYx9Ao_vddYohER0Xn9nIs"; // Replace with your Tenor API key
  final clientKey = "my_test_app"; // Replace with your Tenor client key
  final limit = 10;

  final response = await http.get(
    Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=$searchTerm&key=$apiKey&client_key=$clientKey&limit=$limit"),
  );

  final json = jsonDecode(response.body);
  final List<dynamic> results = json["results"];
  final List<Gif> gifs = results.map((result) => Gif.fromJson(result)).toList();

  return gifs;
}
