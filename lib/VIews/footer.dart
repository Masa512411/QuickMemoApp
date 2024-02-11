import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        // BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Heme'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 202, 205, 116),
      onTap: _onItemTapped,
    );
  }
}
