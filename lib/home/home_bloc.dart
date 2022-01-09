import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/model/stub.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repo = injector.get<Repository>();

  HomeBloc() : super(const HomeState()) {
    on<DirectorySelected>((event, emit) async {
      print("on: DirectorySelected");
      emit(state.copyWith(selectedDir: event.stub));
    });
    on<FileSelected>((event, emit) async {
      print("on: FileSelected");
      emit(state.copyWith(selectedFile: event.stub));
    });
    on<OnHover>((event, emit) async {
      print("on: OnHover");
      if (!state.hovered) {
        emit(state.copyWith(hovered: true));
      }
    });
    on<OnLeave>((event, emit) async {
      print("on: OnLeave");
      emit(state.copyWith(hovered: false));
    });
    on<OnFileUpload>((event, emit) async {
      print("on: OnFileUpload");
      await repo.upload(event);
      repo.refreshPath(event.parentPath);
    });
    init();
  }

  init() async {
    await repo.refreshPath("");
    add(DirectorySelected(repo.getStub("") ?? const Stub.root([])));
  }
}

class HomeState extends Equatable {
  final Stub selectedDir;
  final Stub selectedFile;
  final bool hovered;

  const HomeState({
    this.selectedDir = const Stub.root([]),
    this.hovered = false,
    this.selectedFile = const Stub.root([]),
  });

  @override
  List<Object?> get props => [selectedDir, selectedFile, hovered];

  HomeState copyWith({
    Stub? selectedDir,
    Stub? selectedFile,
    bool? hovered,
  }) {
    return HomeState(
      selectedDir: selectedDir ?? this.selectedDir,
      selectedFile: selectedFile ?? this.selectedFile,
      hovered: hovered ?? this.hovered,
    );
  }
}

class HomeEvent {}

class RefreshContent extends HomeEvent {
  RefreshContent();
}

class DirectorySelected extends HomeEvent {
  final Stub stub;

  DirectorySelected(this.stub);
}

class FileSelected extends HomeEvent {
  final Stub stub;

  FileSelected(this.stub);
}

class OnHover extends HomeEvent {}

class OnLeave extends HomeEvent {}

class OnFileUpload extends HomeEvent {
  final Uint8List bytes;
  final String filename;
  final String mimeType;
  final String parentPath;

  OnFileUpload(this.bytes, this.filename, this.mimeType, this.parentPath);
}
