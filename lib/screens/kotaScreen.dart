import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class Kota extends StatelessWidget {
  const Kota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Pilih tempat wisata berdasarkan kota"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Jakarta"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JktScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Jatim"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JatimScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("NTB"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NtbScreen(),
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

Future<List<dynamic>> fetchWisataJKT() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/jakarta'));
  return json.decode(result.body)['data'];
}

class JktScreen extends StatelessWidget {
  JktScreen({Key? key}) : super(key: key);

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
            future: fetchWisataJKT(),
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

Future<List<dynamic>> fetchWisataJatim() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/jatim'));
  return json.decode(result.body)['data'];
}

class JatimScreen extends StatelessWidget {
  JatimScreen({Key? key}) : super(key: key);

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
            future: fetchWisataJatim(),
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

Future<List<dynamic>> fetchWisataNtb() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/ntb'));
  return json.decode(result.body)['data'];
}

class NtbScreen extends StatelessWidget {
  NtbScreen({Key? key}) : super(key: key);

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
            future: fetchWisataNtb(),
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
