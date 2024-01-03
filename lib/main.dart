import 'dart:convert';
import 'package:delivery2/model/gifmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Api example bar'),
          ),
          body: FutureBuilder(
            future: loadTenorGifs("tonto manel"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text("error: ${snapshot.error}");
              }
              final gif = snapshot.data!;
              return Card(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(gif.name),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

// class _GifWidget extends StatelessWidget {
//   const _GifWidget({
//     super.key,
//     required this.gif,
//   });

//   final Gif gif;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(gif.url),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(gif.name),
//           )
//         ],
//       ),
//     );
//   }
// }
