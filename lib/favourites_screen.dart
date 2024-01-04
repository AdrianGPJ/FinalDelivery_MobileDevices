import 'package:FinalDelivery_MobileDevices/large_gif_screen.dart';
import 'package:FinalDelivery_MobileDevices/model/gifmodel.dart';
import 'package:FinalDelivery_MobileDevices/main.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Gif> favoriteGifs;

  FavoritesScreen({required this.favoriteGifs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade400, Colors.white],
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: favoriteGifs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showLargeGif(context, favoriteGifs[index]),
              child: Card(
                elevation: 4.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white, // Add a square outline color
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                6.0), // Adjust border radius to match the card
                            image: DecorationImage(
                              image: NetworkImage(favoriteGifs[index].url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          favoriteGifs[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.black,
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
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _showLargeGif(BuildContext context, Gif gif) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LargeGifScreen(gif: gif, favoriteGifs: favoriteGifs),
      ),
    );
  }
}
