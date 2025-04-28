import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickly_memo/state/document_provider.dart';
import '../components/common_app_bar.dart';

// import 'package:quickly_memo/pages/list_page.dart';

class TextEditorPage extends ConsumerStatefulWidget {
  const TextEditorPage({super.key});
  @override
  ConsumerState<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends ConsumerState<TextEditorPage> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documents = ref.read(documentsProvider.notifier);
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Quick Memo',
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              final title = _controller.document.toPlainText().split('\n')[0];
              final content = _controller.document.toPlainText();
              try {
                // addDocument を呼び出し
                await documents.addDocument(
                  title, // 1行目をタイトルとして使用
                  content, // 全体を本文として使用
                );
                print('Document added successfully eee $documents');
                // 成功時に前の画面に戻る
                Navigator.of(context).pop(true);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('エラーが発生しました: $e')),
                );
              }
            },
            child: const Text('完了'),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                toolbarIconCrossAlignment: WrapCrossAlignment.start,
                toolbarIconAlignment: WrapAlignment.start,
                multiRowsDisplay: false,
                color: const Color.fromARGB(227, 212, 212, 212),
                toolbarSectionSpacing: 0,
                sectionDividerSpace: 0,
                toolbarSize: 60,
                controller: _controller,
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
                ],
              ),
            ),
          ),
          const Gap(1),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _controller,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
