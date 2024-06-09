import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';
import 'package:quickly_memo/pages/footer.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillController controller = QuillController.basic();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quick Memo'),
        backgroundColor: const Color.fromARGB(255, 202, 205, 116),
      ),
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
                      toolbarSize: 50,
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
