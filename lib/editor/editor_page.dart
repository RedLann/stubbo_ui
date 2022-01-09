import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:stubbo_ui/model/editor_tools.dart';
import 'editor_bloc.dart';
import 'dart:html';

class EditorPage extends StatefulWidget {
  final String filename;

  const EditorPage({Key? key, required this.filename}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final EditorBloc _editorBloc = EditorBloc();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _editorBloc.add(Init(widget.filename));
    });
  }

  @override
  Widget build(BuildContext context) {
    platformViewRegistry.registerViewFactory("jsoneditor", (int viewId) => DivElement()..id = "jsoneditor");
    return BlocProvider(
      create: (context) => _editorBloc,
      child: BlocConsumer<EditorBloc, EditorState>(
        listenWhen: (previous, current) => previous.code.isEmpty && current.code.isNotEmpty,
        listener: (context, state) {
          // _controller.text = state.code;
          prepareEditor(state.code);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () => Navigator.pop(context, ""),
              ),
              title: Text(widget.filename),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: false,
              actions: [IconButton(onPressed: () => context.read<EditorBloc>().add(OnSave(getJson())), icon: const Icon(Icons.save_outlined))],
            ),
            body: const HtmlElementView(viewType: 'jsoneditor'),
          );
        },
      ),
    );
  }
}
