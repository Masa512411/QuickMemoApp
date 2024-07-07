import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:localstore/localstore.dart';
import 'package:quickly_memo/pages/footer.dart';
// import 'package:quickly_memo/pages/list_page.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  _TextEditorPageState createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final QuillController controller = QuillController.basic();
  // late bool _isDocumentEmpty = true;

  @override
  void initState() {
    super.initState();
    // controller.addListener(() => _checkDocumentEmpty);
  }

  Future<void> _docSave(QuillController controller, context) async {
    final db = Localstore.instance;

    final json = controller.document.toDelta().toJson();
    final id = db.collection('doc').doc().id;
    final flag = controller.document.toPlainText().trim().isEmpty;

    await db.collection('todos').doc(id).set(json[0]);
    Fluttertoast.showToast(msg: '保存しました。$flag');
    Navigator.of(context).pop(true);
  }

  // void _checkDocumentEmpty() {
  //   setState(() {
  //     _isDocumentEmpty = controller.document.toPlainText().trim().isEmpty;
  //   });
  // }

  @override
  void dispose() {
    // controller.removeListener(_checkDocumentEmpty);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Quick Memo'),
          // backgroundColor: const Color.fromARGB(255, 202, 205, 116),
          actions: <Widget>[
            TextButton(
              onPressed: () async => {
                await _docSave(controller, context),
              },
              child: const Text('完了'),
            )
            // style: TextStyle(fontWeight: FontWeight.bold))),
          ]),
      body: Column(
        children: [
          Card(
              // decoration: BoxDecoration(),
              child: QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                      toolbarIconCrossAlignment: WrapCrossAlignment.start,
                      toolbarIconAlignment: WrapAlignment.start,
                      multiRowsDisplay: false,
                      color: Color.fromARGB(227, 212, 212, 212),
                      toolbarSectionSpacing: 0,
                      sectionDividerSpace: 0,
                      toolbarSize: 60,
                      controller: controller,
                      showItalicButton: true,
                      showHeaderStyle: false,
                      showFontSize: false,
                      showUnderLineButton: true,
                      showListCheck: true,
                      showListNumbers: true,
                      showListBullets: false,
                      showIndent: false,
                      showRedo: false,
                      showUndo: true,
                      showColorButton: false,
                      showSubscript: false,
                      showSearchButton: false,
                      showSuperscript: false,
                      showStrikeThrough: false,
                      showInlineCode: true,
                      showFontFamily: false,
                      showClearFormat: false,
                      showCodeBlock: false,
                      showQuote: false,
                      showBackgroundColorButton: false,
                      customButtons: [
                QuillToolbarCustomButtonOptions(
                  icon: const Icon(Icons.ac_unit),
                  onPressed: () {
                    debugPrint('snowflake1');
                  },
                ),
              ]))),
          const Gap(1),
          Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: controller,
                        placeholder: "メモ書いてね",
                        textCapitalization: TextCapitalization.none,
                        readOnly: false,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('jp'),
                        ),
                      ),
                      scrollController: ScrollController(),
                      focusNode: FocusNode(),
                    ),
                  )))
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
