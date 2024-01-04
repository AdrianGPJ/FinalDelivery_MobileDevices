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
      widget.favoriteGifs
          .add(widget.gif); // Add the current GIF to the list of favorites
    });
  }

  void _removeFromFavorites() {
    setState(() {
      _isFavorite = false;
      widget.favoriteGifs.remove(
          widget.gif); // Remove the current GIF from the list of favorites
    });
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.favoriteGifs.contains(widget.gif);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gif.name),
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.gif.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                icon: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.yellow,
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
            ],
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How to add to favorites:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Click on the star button, if it is completely yellow the gif is already on favorites, to remove from favorites click another time on the star',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
