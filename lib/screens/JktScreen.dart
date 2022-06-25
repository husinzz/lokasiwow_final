import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TempatWisata {
  final String title;
  final String locationURL;
  final String imageURL;

  const TempatWisata(
      {required this.title, required this.locationURL, required this.imageURL});

  factory TempatWisata.fromJson(Map<String, dynamic> json) {
    return (TempatWisata(
      title: json['name'],
      imageURL: json['image_uri'],
      locationURL: json['location'],
    ));
  }
}

Future<dynamic> fetchWisata() async {
  final response = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/jakarta'));

  if (response.statusCode == 200) {
    return (TempatWisata.fromJson(jsonDecode(response.body)));
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

class JktScreen extends StatelessWidget {
  JktScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata di jakarta"),
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
