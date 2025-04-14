import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';

class MemoCard extends ConsumerWidget {
  MemoCard({
    super.key,
    required this.data,
    required this.listKey,
    required this.onDelete,
  });

  final Map<String, dynamic> data;
  final String listKey;
  final VoidCallback onDelete;

  void deleteDocument() {
    final db = Localstore.instance;
    db.collection('documents').doc(listKey.split('/').last).delete();
    onDelete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(data[listKey]['title'] ?? "Not title"),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            debugPrint('data : ${data['title']}');
            onDelete();
          },
        ),
      ),
    );
  }
}
