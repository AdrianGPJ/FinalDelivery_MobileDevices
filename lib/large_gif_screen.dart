import 'package:FinalDelivery_MobileDevices/model/gifmodel.dart';
import 'package:flutter/material.dart';
import 'package:FinalDelivery_MobileDevices/main.dart';

class LargeGifScreen extends StatefulWidget {
  final Gif gif;
  final List<Gif> favoriteGifs;

  LargeGifScreen({required this.gif, required this.favoriteGifs});

  @override
  _LargeGifScreenState createState() => _LargeGifScreenState();
}

class _LargeGifScreenState extends State<LargeGifScreen> {
  bool _isFavorite = false;

  void _addToFavorites() {
    setState(() {
      _isFavorite = true;
      widget.favoriteGifs.add(widget.gif);
    });
  }

  void _removeFromFavorites() {
    setState(() {
      _isFavorite = false;
      widget.favoriteGifs.remove(widget.gif);
    });
  }

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
}
