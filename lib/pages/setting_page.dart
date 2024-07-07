import 'package:flutter/material.dart';
import 'package:quickly_memo/pages/list_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Setting"));
  }
}
