import 'package:localstore/localstore.dart';

Future<Map<String, dynamic>> getDocuments() async {
  final db = Localstore.instance;

  final data = await db.collection('todos').get();
  return data ?? {};
}
