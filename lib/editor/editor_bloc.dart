import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:http/http.dart' as http;
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/editor/json_formatter.dart';

part 'editor_bloc.g.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final Repository repo = injector.get();

  EditorBloc() : super(const EditorState()) {
    on<Init>((event, emit) => init(event));
    on<OnContentFetched>((event, emit) {
      final code = event.filename.endsWith(".json") ? JsonFormatUtil.formatJson(event.code) : event.code;
      emit(state.copyWith(filename: event.filename, code: code));
    });
    on<OnSave>((event, emit) async {
      await repo.update(state.filename, false, body: event.code);
    });
  }

  init(Init event) async {
    try {
      final response = await http.get(Uri.parse("http://0.0.0.0:8080/view/${event.filename}"));
      add(OnContentFetched(event.filename, response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

@CopyWith()
class EditorState extends Equatable {
  final String filename;
  final String code;

  const EditorState({this.filename = "", this.code = ""});

  @override
  List<Object?> get props => [filename, code];
}

class EditorEvent {}

class Init extends EditorEvent {
  final String filename;

  Init(this.filename);
}

class OnContentFetched extends EditorEvent {
  final String filename;
  final String code;

  OnContentFetched(this.filename, this.code);
}
class OnSave extends EditorEvent {
  final String code;

  OnSave(this.code);
}
