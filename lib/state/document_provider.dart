import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';

// ドキュメントの状態を管理するStateProvider
final documentsProvider =
    StateNotifierProvider<DocumentsNotifier, Map<String, dynamic>>((ref) {
  return DocumentsNotifier();
});

class DocumentsNotifier extends StateNotifier<Map<String, dynamic>> {
  DocumentsNotifier() : super({});

  final db = Localstore.instance;

  // ドキュメント一覧を取得
  Future<Map<String, dynamic>> fetchDocuments() async {
    final documents = await db.collection('documents').get();
    if (documents != null) {
      state = documents;
      return documents;
    }
    return {};
  }

  // ドキュメントを追加
  Future<void> addDocument(String title, String content) async {
    final id = db.collection('documents').doc().id;
    final data = {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      // 非同期処理が完了するまで一時的な状態変更を行わない
      await db.collection('documents').doc(id).set(data).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Database operation timed out');
        },
      );

      // 状態のコピーを作成してから変更
      Future.delayed(Duration.zero, () {
        final newState = Map<String, dynamic>.from(state);
        newState['documents/$id'] = data;
        state = newState;
      });
    } catch (e) {
      // エラーをログに出力
      print('Failed to add document: $e');
      // 必要に応じて例外を再スロー
      throw Exception('Failed to add document: $e');
    }
  }

  // ドキュメントを更新
  Future<void> updateDocument(String id, String title, String content) async {
    final data = {
      'id': id,
      'title': title,
      'content': content,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    await db.collection('documents').doc(id).set(data);
    state = {...state, 'documents/$id': data};
  }

  // ドキュメントを削除
  void deleteDocument(String id) async {
    await db.collection('documents').doc(id).delete();

    final newState = Map<String, dynamic>.from(state);
    newState.remove('documents/$id');
    state = newState;
  }
}
