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
            // You can customize the appearance of each favorite GIF item
          );
        },
      ),
    );
  }
}
