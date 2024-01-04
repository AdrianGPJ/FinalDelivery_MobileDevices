import 'dart:convert';
import 'package:FinalDelivery_MobileDevices/favourites_screen.dart';
import 'package:FinalDelivery_MobileDevices/large_gif_screen.dart';
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
      title: 'GIF Explorer',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
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
  List<Gif> _favoriteGifs = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIF Explorer'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for GIFs',
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
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder(
                future: _searchQuery.isNotEmpty
                    ? loadTenorGifs(_searchQuery, 10)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text("No data available"));
                  }

                  final List<Gif> gifs = snapshot.data as List<Gif>;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: gifs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _showLargeGif(context, gifs[index]),
                        child: Card(
                          elevation: 4.0,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(gifs[index].url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _favoriteGifs.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _showFavorites(context),
              child: Icon(Icons.star),
              backgroundColor: Colors.orange.shade300,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 8.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
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
        builder: (context) =>
            LargeGifScreen(gif: gif, favoriteGifs: _favoriteGifs),
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
