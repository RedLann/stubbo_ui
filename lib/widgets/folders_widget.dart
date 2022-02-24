import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/model/stub.dart';

class FolderWidget extends StatefulWidget {
  final String path;
  final Function(Stub) onSelected;

  const FolderWidget({Key? key, required this.path, required this.onSelected}) : super(key: key);

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  final Repository repo = injector.get();
  bool initialized = false;
  bool collapsed = true;

  @override
  void initState() {
    if (widget.path.isEmpty) {
      collapsed = false;
      initialized = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Stub>>(
      valueListenable: repo.getListenable(widget.path),
      builder: (context, value, child) {
        final item = value.get(widget.path);
        if (item == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final children = item.children.where((element) => element.isDir).toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  initialized = true;
                  if (widget.path.isNotEmpty) {
                    collapsed = !collapsed;
                  }
                });
                widget.onSelected(item);
              },
              child: Row(
                children: [
                  Opacity(
                    opacity: children.isEmpty ? 0 : 1,
                    child: Icon(collapsed ? Icons.arrow_right_outlined : Icons.arrow_drop_down_outlined),
                  ),
                  const Icon(
                    Icons.folder_outlined,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item.name,
                  ),
                ].whereType<Widget>().toList(),
              ),
            ),
            !initialized
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: collapsed ? 0 : null,
                      child: Column(
                        children: List.generate(
                            children.length,
                            (index) => FolderWidget(
                                  key: ValueKey(children[index].path),
                                  path: children[index].path,
                                  onSelected: widget.onSelected,
                                )),
                      ),
                    ),
                  )
          ].whereType<Widget>().toList(),
        );
      },
    );
  }
}
