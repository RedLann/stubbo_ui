import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:http/http.dart' as http;

part 'editor_bloc.g.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(const EditorState()) {
    on<Init>((event, emit) => init(event));
    on<OnContentFetched>((event, emit) => emit(state.copyWith(filename: event.filename, code: event.code)));
  }

  init(Init event) async {
    try {
      final response =
      await http.get(Uri.parse("http://0.0.0.0:8080/anymock/${event.filename}"));
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