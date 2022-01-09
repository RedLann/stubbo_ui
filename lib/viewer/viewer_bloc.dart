import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:http/http.dart' as http;
import 'package:stubbo_ui/constants.dart';
import 'package:stubbo_ui/model/stub.dart';

part 'viewer_bloc.g.dart';

class ViewerBloc extends Bloc<ViewerEvent, ViewerState> {
  ViewerBloc() : super(const ViewerState()) {
    on<Init>((event, emit) => init(event.path));
    on<OnContentFetched>((event, emit) => emit(state.copyWith(current: event.current)));
  }

  Future<List<Stub>> flatten(Stub stub) async {
    List<Stub> flatStubs = [];
    flatStubs.add(stub);
    if (stub.children.isNotEmpty) {
      for(Stub s in stub.children) {
        flatStubs.addAll(await flatten(s));
      }
    }
    return flatStubs;
  }

  init(String path) async {
    try {
      final response =
          await http.get(Uri.parse("${baseurl}api/stree/$path"));
      add(OnContentFetched(Stub.fromJson(jsonDecode(response.body))));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

@CopyWith()
class ViewerState extends Equatable {
  final Stub? current;

  const ViewerState({this.current});

  @override
  List<Object?> get props => [current];
}

class ViewerEvent {}

class Init extends ViewerEvent {
  final String path;
  Init(this.path);
}

class RefreshContent extends ViewerEvent {
  RefreshContent();
}

class OnContentFetched extends ViewerEvent {
  final Stub current;

  OnContentFetched(this.current);
}
