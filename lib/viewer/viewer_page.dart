import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubbo_ui/model/stub.dart';
import 'package:stubbo_ui/viewer/viewer_bloc.dart';

class ViewerPage extends StatefulWidget {
  final String path;

  const ViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  final ViewerBloc _bloc = ViewerBloc();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _bloc.add(Init(widget.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<ViewerBloc, ViewerState>(
        builder: (context, state) {
          final current = state.current;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Viewer"),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh_sharp),
                  onPressed: () => _bloc.add(RefreshContent()),
                )
              ],
            ),
            body: current != null
                ? buildListView(current.children)
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
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
