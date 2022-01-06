import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/directory_widget.dart';
import 'package:stubbo_ui/model/stub.dart';

import '../nav_routes.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();
  final Repository repo = injector.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh_sharp),
                    onPressed: () => _homeBloc.add(RefreshContent()),
                  )
                ],
              ),
              body: ResizableWidget(
                key: UniqueKey(),
                isHorizontalSeparator: false,
                isDisabledSmartHide: false,
                separatorColor: Colors.blue,
                separatorSize: 4,
                percentages: const [0.2, 0.8],
                children: [
                  DirectoryWidget(
                      builder: (context, value, child) {
                        final item = value.get(state.selectedDir.path);
                        return item == null
                            ? const CircularProgressIndicator()
                            : buildDirsListView(item.children.where((element) => element.isDir).toList());
                      },
                      path: state.selectedDir.path),
                  DirectoryWidget(
                      builder: (context, value, child) {
                        final item = value.get(state.selectedDir.path);
                        return item == null
                            ? const CircularProgressIndicator()
                            : buildListView(item.children);
                      },
                      path: state.selectedDir.path),
                ],
              ));
        },
      ),
    );
  }

  Widget buildDirsListView(List<Stub> stubs) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: stubs.length,
      itemBuilder: (context, index) {
        final item = stubs[index];
        return ExpansionTile(
          leading: item.isDir ? const Icon(Icons.folder_outlined) : null,
          title: Text(item.name),
          children: List.generate(item.children.length, (index) => buildDirsListView(item.children)),
          // subtitle: Text(item.path),
          // dense: true,
          // visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          // minVerticalPadding: 0,
          // onTap: () => context.read<HomeBloc>().add(StubSelected(item)),
        );
      },
    );
  }

  Widget buildListView(List<Stub> stubs) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: stubs.length,
      itemBuilder: (context, index) {
        final item = stubs[index];
        return ListTile(
          leading: item.isDir ? const Icon(Icons.folder_outlined) : null,
          title: Text(item.name),
          // subtitle: Text(item.path),
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          minVerticalPadding: 0,
        );
      },
    );
  }
}
