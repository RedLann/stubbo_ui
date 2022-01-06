import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import 'editor_bloc.dart';

class EditorPage extends StatefulWidget {
  final String filename;

  const EditorPage({Key? key, required this.filename}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final EditorBloc _editorBloc = EditorBloc();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _editorBloc.add(Init(widget.filename));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _editorBloc,
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.filename),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: false,
            ),
            body: Center(
              child: state.code.isNotEmpty
                  ? CodeEditor(
                      model: EditorModel(
                        files: [
                          FileEditor(
                            name: state.filename,
                            language: "json",
                            code: state.code,
                          )
                        ],
                        styleOptions: EditorModelStyleOptions(
                          fontSize: 13,
                          editorColor: Colors.white,
                          theme: a11yLightTheme,
                          heightOfContainer: 600,
                        ),
                      ),
                      edit: true,
                      disableNavigationbar: true,
                      onSubmit: (String? language, String? value) {
                        print("language = $language");
                        print("value = '$value'");
                      },
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
