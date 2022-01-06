// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfEditorState.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfEditorState.copyWith.fieldName(...)`
class _EditorStateCWProxy {
  final EditorState _value;

  const _EditorStateCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `EditorState(...).copyWithNull(...)` to set certain fields to `null`. Prefer `EditorState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditorState(...).copyWith(id: 12, name: "My name")
  /// ````
  EditorState call({
    String? code,
    String? filename,
  }) {
    return EditorState(
      code: code ?? _value.code,
      filename: filename ?? _value.filename,
    );
  }

  EditorState code(String code) => this(code: code);

  EditorState filename(String filename) => this(filename: filename);
}

extension EditorStateCopyWith on EditorState {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass EditorState extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass EditorState extends Equatable.name.copyWith.fieldName(...)`
  _EditorStateCWProxy get copyWith => _EditorStateCWProxy(this);
}
