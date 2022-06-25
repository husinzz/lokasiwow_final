import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class Blog {
  final String title;
  final String content;

  const Blog({required this.title, required this.content});
}

Future<List<dynamic>> fetchWisata() async {
  var result = await http
      .get(Uri.parse('https://morning-springs-87133.herokuapp.com/blogs'));
  return json.decode(result.body)['data'];
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          children: [Text(data['content'])],
        ));
  }
}

class BlogScreen extends StatelessWidget {
  BlogScreen({Key? key}) : super(key: key);

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
                            title: Text(snapshot.data[index]['title']),
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
