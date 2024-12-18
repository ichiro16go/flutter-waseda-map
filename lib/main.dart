import 'package:flutter/material.dart';
import './pages/detailPage.dart';
import './pages/homePage.dart';
import './pages/mapPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MapPage(),
    const HomePage(),
    const DetailPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(155, 0, 63, 1), // 指定された色
        title: const Text(
          'WaseMap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white // ボールドフォント
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
            bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.white), // アイコンの色を白に
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white), // アイコンの色を白に
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.white), // アイコンの色を白に
            label: 'Detail',
          ),
        ],
        backgroundColor: const Color.fromRGBO(155, 0, 63, 1), // えんじ色
        selectedItemColor: Colors.white, // 選択されたアイテムの色を白に
        unselectedItemColor: const Color.fromARGB(178, 255, 255, 255), // 未選択のアイテムの色を白に
      ),
    );
  }
}