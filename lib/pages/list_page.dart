import 'package:flutter/material.dart';
import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';
import 'package:localstore/localstore.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ListPage> {
  final db = Localstore.instance;

  Future<Map<String, dynamic>> getDocuments() async {
    final data = await db.collection('todos').get();
    if (data != null) {
      return data;
    } else {
      return {};
    }
  }

  Future<void> deleteDocument(String id) async {
    await db.collection('todos').doc(id).delete();
    setState(() {}); // 状態を更新して再描画をトリガー
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
        future: getDocuments(),
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
              var id = keys[index].split('/').last;
              var key = keys[index];
              return Card(
                child: ListTile(
                  title: Text('${data[key]['insert']}'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      deleteDocument(id);
                    },
                  ),
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
