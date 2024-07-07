import 'package:flutter/material.dart';
import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';
import 'package:localstore/localstore.dart';

import '../components/memo_card.dart';
import '../repository/search_document.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ListPage> {
  final db = Localstore.instance;

  late Future<Map<String, dynamic>> _documents;

  @override
  void initState() {
    super.initState();
    _documents = getDocuments();
  }

  // リストの再描画
  void refreshList() {
    setState(() {
      _documents = getDocuments();
    });
  }

  //　TextEditorPageへの遷移
  void textEditorPageWithReloadByReturn(BuildContext context) async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const TextEditorPage()));
    if (result != null) {
      refreshList();
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
        future: _documents,
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
              var id = key.split('/').last;
              return MemoCard(
                data: data,
                listKey: key,
                onDelete: refreshList,
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
            textEditorPageWithReloadByReturn(context);
          },
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
