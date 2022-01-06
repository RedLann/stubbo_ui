import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:stubbo_ui/assets/constants_images.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/editor/editor_page.dart';
import 'package:stubbo_ui/widgets/folders_widget.dart';
import 'package:path/path.dart' as p;

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
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
          separatorColor: Colors.blue,
          separatorSize: 4,
          percentages: const [0.25, 0.75],
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SingleChildScrollView(
                    child: FolderWidget(
                      path: "",
                      onSelected: (item) => context.read<HomeBloc>().add(DirectorySelected(item)),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => Container(
                color: Colors.white,
                child: ListView.separated(
                  controller: ScrollController(),
                  itemCount: state.files.length,
                  itemBuilder: (context, index) {
                    final item = state.files[index];
                    return ListTile(
                      leading: item.isDir
                          ? const Icon(
                              Icons.folder_outlined,
                              color: Colors.blue,
                            )
                          : _buildFileIcon(item.path),
                      title: Text(
                        item.name,
                      ),
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      // onTap: () => context.read<HomeBloc>().add(FileSelected(item)),
                      onTap: () => _showDialog(item.path),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Container(color: Colors.grey, height: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(String path) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: EditorPage(filename: path),
        );
      },
    );
  }

  Widget? _buildFileIcon(String path) {
    final extension = p.extension(path);
    final image = extensionMap[extension];
    if (image == null) {
      return null;
    }
    return Image.asset(image, fit: BoxFit.fill);
  }
}

const extensionMap = {
  ".doc": Images.doc,
  ".docx": Images.doc,
  ".html": Images.html,
  ".jpg": Images.jpg,
  ".jpeg": Images.jpg,
  ".pdf": Images.pdf,
  ".png": Images.png,
  ".ppt": Images.ppt,
  ".txt": Images.txt,
  ".xls": Images.xls,
  ".xlsx": Images.xls,
  ".xml": Images.xml,
  ".zip": Images.zip,
  ".json": Images.json,
};