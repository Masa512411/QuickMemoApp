import 'package:flutter/material.dart';
import 'package:quickly_memo/components/footer.dart';
import 'package:quickly_memo/pages/text_editor.dart';

import 'common_app_bar.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool isShowBackButton;
  final bool isFloatingActionButton;
  final int selectedIndex;
  final Function(int)? onTapped;

  const CommonScaffold(
    String s, {
    Key? key,
    required this.body,
    this.title = '',
    required this.selectedIndex,
    required this.onTapped,
    this.isShowBackButton = false,
    this.isFloatingActionButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: title),
      body: body,
      bottomNavigationBar: Footer(
        selectedIndex: selectedIndex,
        onTapped: onTapped,
      ),
      floatingActionButtonLocation: isFloatingActionButton
          ? FloatingActionButtonLocation.centerDocked
          : null,
      floatingActionButton: isFloatingActionButton
          ? SizedBox(
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
            )
          : null,
    );
  }
}

//　TextEditorPageへの遷移
void textEditorPageWithReloadByReturn(BuildContext context) async {
  final result = await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const TextEditorPage()));
  if (result != null) {
    // refreshList();
  }
}
