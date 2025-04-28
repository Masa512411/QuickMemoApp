import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickly_memo/state/document_provider.dart';

import '../components/memo_card.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentsProvider);
    return documents.isEmpty
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
          );
  }
}
