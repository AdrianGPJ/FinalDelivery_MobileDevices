import 'dart:convert';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api example bar'),
      ),
      body: Column(
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
                    .map((gif) => Card(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(gif.url),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(gif.name),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }
}
