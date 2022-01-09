import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/model/stub.dart';
import 'package:stubbo_ui/widgets/files_widget.dart';
import 'package:stubbo_ui/widgets/folders_widget.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();

  final Repository repo = injector.get();

  late DropzoneViewController _dropController;

  final UniqueKey _folderKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => Text(state.selectedDir.name),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_sharp),
              onPressed: () => _homeBloc.add(RefreshContent()),
            ),
            const SizedBox(width: 30),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Html(
              data:
              '<div>Icons made by <a href="https://www.flaticon.com/authors/dimitry-miroliubov" title="Dimitry Miroliubov">Dimitry Miroliubov</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>'),
        ),
        body: ResizableWidget(
          key: UniqueKey(),
          isHorizontalSeparator: false,
          isDisabledSmartHide: false,
          separatorColor: Colors.blueGrey,
          separatorSize: 4,
          percentages: const [0.25, 0.75],
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SingleChildScrollView(
                child: FolderWidget(
                  key: const ValueKey("ROOTPATH"),
                  path: "",
                  onSelected: (item) => _homeBloc.add(DirectorySelected(item)),
                ),
              ),
            ),
            Stack(
              children: [
                DropzoneView(
                  operation: DragOperation.copy,
                  onCreated: (DropzoneViewController ctrl) => _dropController = ctrl,
                  onLoaded: () => print('Zone loaded'),
                  onError: (String? ev) => print('Error: $ev'),
                  onHover: () {
                    _homeBloc.add(OnHover());
                  },
                  onDrop: (dynamic ev) async {
                    _homeBloc.add(OnFileUpload(
                      await _dropController.getFileData(ev),
                      await _dropController.getFilename(ev),
                      await _dropController.getFileMIME(ev),
                      _homeBloc.state.selectedDir.path,
                    ));
                    _homeBloc.add(OnLeave());
                  },
                  onLeave: () {
                    _homeBloc.add(OnLeave());
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return FilesWidget(
                      path: state.selectedDir.path,
                      onDirDoubleTap: (Stub item) {
                        if (item.isDir) {
                          _homeBloc.add(DirectorySelected(item));
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: context
                          .watch<HomeBloc>()
                          .state
                          .hovered ? true : false,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                          color: Colors.blue[50],
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                              "Drop files here",
                              style: TextStyle(fontSize: 50, color: Colors.white),
                            )),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
