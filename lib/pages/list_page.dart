import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';
import 'package:quickly_memo/state/document_provider.dart';

import '../components/memo_card.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentsProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quick Memo'),
        backgroundColor: const Color.fromARGB(255, 202, 205, 116),
      ),
      body: documents.isEmpty
          ? const Center(
              child: Text(
                'No data',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var key = documents.keys.elementAt(index);
                var id = key.split('/').last;

                return MemoCard(
                  data: documents,
                  listKey: key,
                  onDelete: () {
                    debugPrint('Deleting document with ID: $id');
                    ref.read(documentsProvider.notifier).deleteDocument(id);
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

//　TextEditorPageへの遷移
void textEditorPageWithReloadByReturn(BuildContext context) async {
  final result = await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TextEditorPage()));
  if (result != null) {
    // refreshList();
  }
}


// }
