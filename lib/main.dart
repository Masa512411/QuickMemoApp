import 'package:flutter/material.dart';
import 'package:quickly_memo/VIews/footer.dart';
import 'package:quickly_memo/VIews/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quick Memo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 202, 205, 116)),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Quick Memo'),
            backgroundColor: const Color.fromARGB(255, 202, 205, 116),
          ),
          body: const HomePage(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {},
          ),
          bottomNavigationBar: const Footer(),
        ));
  }
}
