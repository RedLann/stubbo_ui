import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stubbo_ui/model/stub.dart';

class LocalDatasource {
  late final Box<Stub> box;

  LocalDatasource();

  openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StubAdapter());
    box = await Hive.openBox("box");
  }

  ValueListenable<Box<Stub>> listenable(String path) {
    return box.listenable(keys: [path]);
  }

  bool isDataFresh(String path) {
    return (box.get(path)?.timestamp ?? double.infinity) <
        (Stub.currentTimeStamp() - 30 * 60 * 1000);
  }

  Stub? getStub(String path) {
    return box.get(path);
  }

  Future<void> putStub(Stub stub) {
    return box.put(stub.path, stub);
  }

  dispose() {
    box.close();
  }
}
