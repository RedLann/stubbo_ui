import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/model/stub.dart';

part 'home_bloc.g.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repo = injector.get<Repository>();

  HomeBloc() : super(const HomeState()) {
    on<DirectorySelected>((event, emit) async {
      emit(state.copyWith(selectedDir: event.stub, files: event.stub.children));
    });
    on<FileSelected>((event, emit) async {
      emit(state.copyWith(selectedFile: event.stub));
    });
    add(DirectorySelected(const Stub.root([])));
  }

  init() async {}
}

@CopyWith()
class HomeState extends Equatable {
  final Stub selectedDir;
  final List<Stub> files;
  final Stub selectedFile;

  const HomeState({
    this.selectedDir = const Stub.root([]),
    this.files = const [],
    this.selectedFile = const Stub.root([]),
  });

  @override
  List<Object?> get props => [selectedDir, selectedFile, files];
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
