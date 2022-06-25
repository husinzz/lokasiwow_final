import 'package:flutter/material.dart';

class TempatWisata {
  final String title;
  final String locationURL;
  final String imageURL;

  const TempatWisata(this.title, this.locationURL, this.imageURL);
}

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

// class DefaultPage extends StatelessWidget {
//   const DefaultPage({super.key, Home});

//   @override
//   Widget build(BuildContext context) {

//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _WidgetOptions = <Widget>[
    MainScreen(),
    // LocationList(),
    // CategoryList(),
    // BlogList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        child: _WidgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    ));
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

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<TempatWisata> card =
      List.generate(9, (index) => TempatWisata("$index", "", ""));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasiwow - Tempat Wisata"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: card.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.asset(card[index].imageURL),
                ListTile(
                  title: Text(card[index].title),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(),
                                      settings: RouteSettings(
                                        arguments: card[index],
                                      )))
                            },
                        child: Text("Pelajari Lebih lanjut")),
                    TextButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen()))
                            },
                        child: Text("Peta"))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
