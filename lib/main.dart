import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lokasiwow_final/screens/MainScreen.dart';
import 'package:lokasiwow_final/screens/kotaScreen.dart';
import 'package:lokasiwow_final/screens/BlogScreen.dart';
import 'package:lokasiwow_final/screens/kategoriScreen.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _WidgetOptions = <Widget>[
    MainScreen(),
    BlogScreen(),
    Kota(),
    Kategori(),
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
            icon: Icon(Icons.attractions),
            label: 'Tempat wisata',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode_outlined),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Kota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori wisata',
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
