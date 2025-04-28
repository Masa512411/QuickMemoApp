import 'package:flutter/material.dart';
import 'package:quickly_memo/components/common_scaffold.dart';
import 'package:quickly_memo/pages/list_page.dart';
import 'package:quickly_memo/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    ListPage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      'Quick Memo',
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      selectedIndex: _selectedIndex,
      onTapped: _onItemTapped,
      isFloatingActionButton: _selectedIndex == 0 ? true : false,
    );
  }
}
