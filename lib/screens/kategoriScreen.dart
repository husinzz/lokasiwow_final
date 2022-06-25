import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class Kategori extends StatelessWidget {
  const Kategori({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Pilih tempat wisata berdasarkan kota"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Seni Budaya"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeniScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Gunung"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GunungScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Pantai"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantaiScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Religi"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReligiScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}

class TempatWisata {
  final String title;
  final String locationURL;
  final String imageURL;

  const TempatWisata(
      {required this.title, required this.locationURL, required this.imageURL});
}

Future<List<dynamic>> fetchWisataSeni() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/seni'));
  return json.decode(result.body)['data'];
}

class SeniScreen extends StatelessWidget {
  SeniScreen({Key? key}) : super(key: key);

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'could not lunch';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: fetchWisataSeni(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(snapshot.data[index]['image_url']),
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () => {
                                        js.context.callMethod('open', [
                                          snapshot.data[index]['location_url']
                                        ])
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

Future<List<dynamic>> fetchWisataGunung() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/gunung'));
  return json.decode(result.body)['data'];
}

class GunungScreen extends StatelessWidget {
  GunungScreen({Key? key}) : super(key: key);

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'could not lunch';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: fetchWisataGunung(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(snapshot.data[index]['image_url']),
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () => {
                                        js.context.callMethod('open', [
                                          snapshot.data[index]['location_url']
                                        ])
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

Future<List<dynamic>> fetchWisataPantai() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/pantai'));
  return json.decode(result.body)['data'];
}

class PantaiScreen extends StatelessWidget {
  PantaiScreen({Key? key}) : super(key: key);

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'could not lunch';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: fetchWisataPantai(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(snapshot.data[index]['image_url']),
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () => {
                                        js.context.callMethod('open', [
                                          snapshot.data[index]['location_url']
                                        ])
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

Future<List<dynamic>> fetchWisataReligi() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/religi'));
  return json.decode(result.body)['data'];
}

class ReligiScreen extends StatelessWidget {
  ReligiScreen({Key? key}) : super(key: key);

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'could not lunch';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lokasiwow - Tempat Wisata"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: fetchWisataReligi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(snapshot.data[index]['image_url']),
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () => {
                                        js.context.callMethod('open', [
                                          snapshot.data[index]['location_url']
                                        ])
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
