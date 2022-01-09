import 'dart:html';
import 'dart:js';

import 'package:js/js.dart';

@JS()
class JSONEditor {
  external JSONEditor(Element element, dynamic options);
  external void set(dynamic json);
  external String get();
  external Map<String, dynamic> modes;
}