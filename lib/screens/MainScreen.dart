import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class TempatWisata {
//   final String title;
//   final String locationURL;
//   final String imageURL;

//   const TempatWisata(this.title, this.locationURL, this.imageURL);
// }

class TempatWisata {
  final String title;
  final String locationURL;
  final String imageURL;

  const TempatWisata(
      {required this.title, required this.locationURL, required this.imageURL});

  factory TempatWisata.fromJson(Map<dynamic, dynamic> json) {
    return (TempatWisata(
      title: json['name'],
      imageURL: json['image_uri'],
      locationURL: json['location'],
    ));
  }
}

Future<TempatWisata> fetchWisata() async {
  final response =
      await http.get(Uri.parse('https://morning-springs-87133.herokuapp.com/'));

  if (response.statusCode == 200) {
    return TempatWisata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load tempat wisata');
  }
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

// class MainScreen extends StatelessWidget {
//   MainScreen({Key? key}) : super(key: key);

//   final List<TempatWisata> card =
//       List.generate(9, (index) => TempatWisata("$index", "", ""));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Lokasiwow - Tempat Wisata"),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: card.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: Column(
//               children: [
//                 Image.asset(card[index].imageURL),
//                 ListTile(
//                   title: Text(card[index].title),
//                 ),
//                 ButtonBar(
//                   alignment: MainAxisAlignment.start,
//                   children: [
//                     TextButton(
//                         onPressed: () => {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailScreen(),
//                                       settings: RouteSettings(
//                                         arguments: card[index],
//                                       )))
//                             },
//                         child: Text("Pelajari Lebih lanjut")),
//                     TextButton(
//                         onPressed: () => {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailScreen()))
//                             },
//                         child: Text("Peta"))
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  // final List<TempatWisata> card =
  //     List.generate(9, (index) => TempatWisata("$index", "", ""));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            FutureBuilder<dynamic>(
                future: fetchWisata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.lenght,
                      itemBuilder: (context, index) {
                        print(snapshot);
                        return Card(
                          child: Column(
                            children: [
                              Image.asset(snapshot.data[index].imageURL),
                              ListTile(
                                title: Text(snapshot.data[index].title),
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

                  return const CircularProgressIndicator();
                })
          ],
        ));
  }
}

// class _MainScreen extends StatefulWidget {
//   const _MainScreen({Key? key}) : super(key: key);

//   @override
//   State<_MainScreen> createState() => __MainScreenState();
// }

// class __MainScreenState extends State<_MainScreen> {
//   late Future<dynamic> futureTempatWisata;

//   @override
//   void initState() {
//     super.initState();
//     futureTempatWisata = fetchWisata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Lokasiwow - Tempat Wisata"),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             FutureBuilder<dynamic>(
//                 future: futureTempatWisata,
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       itemCount: snapshot.data.lenght,
//                       itemBuilder: (context, index) {
//                         print(snapshot);
//                         return Card(
//                           child: Column(
//                             children: [
//                               Image.asset(snapshot.data[index].imageURL),
//                               ListTile(
//                                 title: Text(snapshot.data[index].title),
//                               ),
//                               ButtonBar(
//                                 alignment: MainAxisAlignment.start,
//                                 children: [
//                                   TextButton(
//                                       onPressed: () => {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         DetailScreen(),
//                                                     settings: RouteSettings(
//                                                       arguments:
//                                                           snapshot.data[index],
//                                                     )))
//                                           },
//                                       child: Text("Pelajari Lebih lanjut")),
//                                   TextButton(
//                                       onPressed: () => {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         DetailScreen()))
//                                           },
//                                       child: Text("Peta"))
//                                 ],
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }

//                   return const CircularProgressIndicator();
//                 })
//           ],
//         ));
//   }
// }
