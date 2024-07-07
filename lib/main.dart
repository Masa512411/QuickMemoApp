import 'package:flutter/material.dart';
// import 'package:quickly_memo/pages/footer.dart';
import 'package:quickly_memo/pages/list_page.dart';
// import 'package:quickly_memo/pages/text_editor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quick Memo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 202, 205, 116)),
          useMaterial3: true,
        ),
        home: const ListPage());
  }
}
