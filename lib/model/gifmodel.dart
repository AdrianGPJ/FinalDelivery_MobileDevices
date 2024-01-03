import 'dart:convert';

import 'package:http/http.dart' as http;

// class Gif {
//   String name;
//   String url;

//   Gif.fromJson(Map<String, dynamic> json)
//       : name = json["title"],
//         url = json["images"]["fixed_width_downsampled"]["url"];
// }

// Future<List<Gif>> loadGifs() async {
//   final response = await http.get(
//     Uri.parse(
//         "https://api.giphy.com/v1/gifs/trending?api_key=rqJcaYvHrheC4rhsOIVP5RpoX6LOQ8GE&limit=2&offset=0&rating=g&bundle=messaging_non_clips"),
//   );
//   final json = jsonDecode(response.body);
//   final jsonGifList = json["data"];
//   List<Gif> gifList = [];
//   for (final jsonGif in jsonGifList) {
//     gifList.add(Gif.fromJson(jsonGif));
//   }
//   return gifList;
// }

class Gif {
  String name;
  String url;

  Gif.fromJson(json)
      : name = json["title"],
        url = json["media_formats"]["nanogif"]["url"];
}

Future<Gif> loadTenorGifs(String searchTerm) async {
  final apiKey =
      "AIzaSyAX3gTNScKbmNYx9Ao_vddYohER0Xn9nIs"; // Replace with your Tenor API key
  final clientKey = "my_test_app"; // Replace with your Tenor client key
  final limit = 1;

  final response = await http.get(
    Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=$searchTerm&key=$apiKey&client_key=$clientKey&limit=$limit"),
  );

  final json = jsonDecode(response.body);
  final gif = Gif.fromJson(json["results"][0]);

  return gif;
}
