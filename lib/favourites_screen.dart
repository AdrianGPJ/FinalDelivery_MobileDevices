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
      ),
      body: ListView.builder(
        itemCount: favoriteGifs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteGifs[index].name),
            subtitle: Image.network(
              favoriteGifs[index].url,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
