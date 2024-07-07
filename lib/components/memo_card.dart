import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class MemoCard extends StatelessWidget {
  const MemoCard({
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
    db.collection('todos').doc(listKey.split('/').last).delete();
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${data[listKey]['insert']}'),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            deleteDocument();
          },
        ),
      ),
    );
  }
}
