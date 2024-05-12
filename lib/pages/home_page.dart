import 'package:flutter/material.dart';
import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quick Memo'),
        backgroundColor: const Color.fromARGB(255, 202, 205, 116),
      ),
      body: const Center(
        child: Text(
          "Hello",
          style: TextStyle(fontSize: 100),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TextEditor()));
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
