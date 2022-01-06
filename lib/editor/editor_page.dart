import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'editor_bloc.dart';

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
    return BlocProvider(
      create: (context) => _editorBloc,
      child: BlocConsumer<EditorBloc, EditorState>(
        listenWhen: (previous, current) => previous.code.isEmpty && current.code.isNotEmpty,
        listener: (context, state) {
          _controller.text = state.code;
        },
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
                  ? TextField(controller: _controller, maxLines: 1000000)
                  : const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
