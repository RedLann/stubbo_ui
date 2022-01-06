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
    // on<Init>((event, emit) => init());
    // on<RefreshContent>((event, emit) {
    //   // emit(const HomeState());
    //   // return init();
    // });
    // on<OnContentFetched>((event, emit) {
    //   emit(state.copyWith(tree: event.stub));
    //   flatten(event.stub).then((value) {});
    // });
    // on<OnContentFlattened>((event, emit) {
    //   // emit(state.copyWith(flatTree: event.flatStubs, flatDirs: event.flatDirs));
    // });
    on<StubSelected>((event, emit) async {
      emit(state.copyWith(selectedDir: event.stub));
      if (event.stub.children.isEmpty) {
        final value = await repo.listAll(path: event.stub.path);
        event.stub.children.clear();
        event.stub.children.addAll(value.children);
        emit(state.copyWith(selectedDir: event.stub));
      }
    });
    add(StubSelected(Stub.root([])));
  }

  // Future<List<StubUiModel>> flatten(Stub stub, {int lvl = 1}) async {
  //   var level = lvl;
  //   List<StubUiModel> flatStubs = [];
  //   flatStubs.add(convert(stub, level));
  //   if (stub.children.isNotEmpty) {
  //     for (Stub s in stub.children) {
  //       flatStubs.addAll(await flatten(s, lvl: level + 1));
  //     }
  //   }
  //   return flatStubs;
  // }

  // StubUiModel convert(Stub stub, int level) {
  //   return StubUiModel.from(stub, level);
  // }

  init() async {}
}

@CopyWith()
class HomeState extends Equatable {
  final Stub tree;
  final Stub selectedDir;

  const HomeState({
    this.tree = const Stub.root([]),
    this.selectedDir = const Stub.root([]),
  });

  @override
  List<Object?> get props => [tree, selectedDir];
}

class HomeEvent {}

class Init extends HomeEvent {
  Init();
}

class RefreshContent extends HomeEvent {
  RefreshContent();
}

class StubSelected extends HomeEvent {
  final Stub stub;

  StubSelected(this.stub);
}

class OnContentFetched extends HomeEvent {
  final Stub stub;

  OnContentFetched(this.stub);
}

// class OnContentFlattened extends HomeEvent {
//   final List<Stub> tree;
//
//   OnContentFlattened(this.tree);
// }
