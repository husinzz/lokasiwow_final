import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lokasiwow_final/screens/JktScreen.dart';

// class TempatWisata {
//   final String title;
//   final String locationURL;
//   final String imageURL;

//   const TempatWisata(
//       {required this.title, required this.locationURL, required this.imageURL});

//   factory TempatWisata.fromJson(Map<List, dynamic> json) {
//     return TempatWisata(
//       title: json['name'],
//       imageURL: json['image_uri'],
//       locationURL: json['location'],
//     );
//   }
// }

class TempatWisata {
  final String title;
  final String locationURL;
  final String imageURL;

  const TempatWisata(
      {required this.title, required this.locationURL, required this.imageURL});
}

// Future<TempatWisata> fetchWisata() async {
//   final response =
//       await http.get(Uri.parse('https://morning-springs-87133.herokuapp.com/'));

//   if (response.statusCode == 200) {
//     return TempatWisata.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load tempat wisata');
//   }
// }

Future<List<dynamic>> fetchWisata() async {
  var result =
      await http.get(Uri.parse('https://morning-springs-87133.herokuapp.com/'));
  return json.decode(result.body)['data'];
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as TempatWisata;

    return Scaffold(
        appBar: AppBar(
          title: Text(data.title),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          children: [
            Image.asset("assets/placeholder.png"),
          ],
        ));
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  // late Future<List<dynamic>> futureWisata = fetchWisata();

  // final List<TempatWisata> card = List.generate(8,
  //     (index) => TempatWisata(title: "$index", locationURL: "", imageURL: ""));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: fetchWisata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(),
                                                settings: RouteSettings(
                                                  arguments:
                                                      snapshot.data[index],
                                                )))
                                      },
                                  child: Text("Pelajari Lebih lanjut")),
                              TextButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen()))
                                      },
                                  child: Text("Peta"))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
