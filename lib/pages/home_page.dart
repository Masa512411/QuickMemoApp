import 'package:flutter/material.dart';
import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';
import 'package:localstore/localstore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final db = Localstore.instance;

  Future<Map<String, dynamic>> getDoc() async {
    final data = await db.collection('todos').get();
    if (data != null) {
      return data;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quick Memo'),
        backgroundColor: const Color.fromARGB(255, 202, 205, 116),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getDoc(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            // エラー
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final data = snapshot.data!;
          final keys = data.keys.toList();
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              var key = keys[index];
              return Card(
                child: ListTile(
                  title: Text('${data[key]['insert']} : $key'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TextEditor()));
          },
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
