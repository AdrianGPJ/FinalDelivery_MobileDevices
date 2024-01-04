import 'dart:convert';
import 'package:FinalDelivery_MobileDevices/favourites_screen.dart';
import 'package:FinalDelivery_MobileDevices/model/gifmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _currentIndex = 0;
  List<Gif> _favoriteGifs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api example bar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _updateSearchQuery("");
                    },
                  ),
                ),
                onChanged: (value) {
                  _updateSearchQuery(value);
                },
              ),
            ),
            FutureBuilder(
              future: _searchQuery.isNotEmpty
                  ? loadTenorGifs(_searchQuery, 10)
                  : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return Text("No data available");
                }

                final List<Gif> gifs = snapshot.data as List<Gif>;

                return Column(
                  children: gifs
                      .asMap()
                      .entries
                      .map((entry) => GestureDetector(
                            onTap: () => _showLargeGif(context, entry.value),
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(entry.value.url),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(entry.value.name),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1) {
              _showFavorites(context);
            }
          });
        },
      ),
    );
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _showLargeGif(BuildContext context, Gif gif) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LargeGifScreen(gif: gif),
      ),
    );
  }

  void _showFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(favoriteGifs: _favoriteGifs),
      ),
    );
  }
}

class LargeGifScreen extends StatefulWidget {
  final Gif gif;

  LargeGifScreen({required this.gif});

  @override
  _LargeGifScreenState createState() => _LargeGifScreenState();
}

class _LargeGifScreenState extends State<LargeGifScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gif.name),
      ),
      body: Column(
        children: [
          IconButton(
            icon: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
                if (_isFavorite) {
                  _addToFavorites();
                } else {
                  _removeFromFavorites();
                }
              });
            },
          ),
          Expanded(
            child: Center(
              child: Image.network(
                widget.gif.url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToFavorites() {
    // Add the current GIF to the list of favorites
  }

  void _removeFromFavorites() {
    // Remove the current GIF from the list of favorites
  }
}
