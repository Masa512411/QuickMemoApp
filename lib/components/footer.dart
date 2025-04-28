import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final int selectedIndex;
  final void Function(int)? onTapped;

  const Footer({
    Key? key,
    required this.selectedIndex,
    required this.onTapped,
  }) : super(key: key);

  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        // BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Heme'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ],
      currentIndex: widget.selectedIndex, // widget.selectedIndexを使用
      selectedItemColor: const Color.fromARGB(255, 202, 205, 116),
      onTap: widget.onTapped,
    );
  }
}
