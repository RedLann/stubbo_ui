import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stubbo_ui/data/repository.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/model/stub.dart';

class DirectoryWidget extends StatefulWidget {
  final ValueWidgetBuilder<Box<Stub>> builder;
  final String path;

  const DirectoryWidget({Key? key, required this.builder, required this.path})
      : super(key: key);

  @override
  State<DirectoryWidget> createState() => _DirectoryWidgetState();
}

class _DirectoryWidgetState extends State<DirectoryWidget> {
  final Repository repo = injector.get();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: repo.getListenable(widget.path),
      builder: widget.builder,
    );
  }
}
