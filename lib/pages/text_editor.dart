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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 38, 26, 25)),
                    borderRadius: BorderRadius.circular(10)),
                child: QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                        controller: controller,
                        showItalicButton: true,
                        showHeaderStyle: false,
                        showFontSize: false,
                        showUnderLineButton: false,
                        showListCheck: true,
                        showListNumbers: true,
                        showListBullets: false,
                        showIndent: false,
                        showRedo: true,
                        showUndo: true,
                        showColorButton: false,
                        showSubscript: false,
                        showSearchButton: false,
                        showSuperscript: false,
                        showStrikeThrough: false,
                        showInlineCode: false,
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
            const Gap(10),
            SizedBox(
                height: 500,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5, color: Color.fromARGB(255, 124, 123, 123)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: controller,
                          readOnly: false,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('en'),
                          ),
                        ),
                        scrollController: ScrollController(),
                        focusNode: FocusNode(),
                      ),
                    )))
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
