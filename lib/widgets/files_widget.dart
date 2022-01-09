import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:stubbo_ui/assets/constants_images.dart';
import 'package:stubbo_ui/constants.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/editor/editor_page.dart';
import 'package:stubbo_ui/model/stub.dart';
import 'package:path/path.dart' as p;

class FilesWidget extends StatefulWidget {
  final String path;
  final Function(Stub) onDirDoubleTap;

  const FilesWidget({Key? key, required this.path, required this.onDirDoubleTap}) : super(key: key);

  @override
  State<FilesWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FilesWidget> {
  final Repository repo = injector.get();
  String selectedPath = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AnimatedContainer(
          height: selectedPath.isNotEmpty ? 70 : 0,
          duration: const Duration(milliseconds: 100),
          color: Colors.blue,
          child: ListTile(
            title: Text(widget.path),
          ),
        ),
        ValueListenableBuilder<Box<Stub>>(
          valueListenable: repo.getListenable(widget.path),
          builder: (context, value, child) {
            final item = value.get(widget.path);
            if (item == null) {
              return const CircularProgressIndicator();
            }
            final children = item.children.where((element) => !element.isDir).toList();
            children.sort((a, b) => a.name.compareTo(b.name));
            return Expanded(
              child: ListView.separated(
                controller: ScrollController(),
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final item = children[index];
                  // final isSelected = item.path == selectedPath;
                  final selected = selectedPath == item.path;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedPath == item.path) {
                          selectedPath = "";
                        } else {
                          selectedPath = item.path;
                        }
                      });
                    },
                    onDoubleTap: () {
                      if (item.path.endsWith(".json")) {
                        _showDialog(item.path);
                      } else if (item.isDir) {
                        widget.onDirDoubleTap(item);
                      }
                      selectedPath = item.path;
                    },
                    child: Card(
                      color: selected ? Colors.blue[100] : Colors.white,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      borderOnForeground: true,
                      elevation: 0,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ListTile(
                        leading: item.isDir
                            ? const Icon(
                                Icons.folder_outlined,
                                color: Colors.blue,
                              )
                            : _buildFileIcon(item.path),
                        title: Text(
                          item.name,
                          style: TextStyle(
                              color: selected ? Colors.blue : null, fontWeight: selected ? FontWeight.bold : null),
                        ),
                        trailing: GestureDetector(
                          onTap: () {},
                          onDoubleTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                splashRadius: 20,
                                tooltip: "Copy link",
                                onPressed: () => Clipboard.setData(ClipboardData(text: baseurl + "view/" + item.path)),
                                icon: const Icon(Icons.link),
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(baseurl + "view/" + item.path),
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        minLeadingWidth: 0,
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        selected: selected,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Container(color: Colors.grey[200], height: 1),
              ),
            );
          },
        ),
      ],
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
