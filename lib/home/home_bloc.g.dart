// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfHomeState.copyWith.fieldName(...)`
class _HomeStateCWProxy {
  final HomeState _value;

  const _HomeStateCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `HomeState(...).copyWithNull(...)` to set certain fields to `null`. Prefer `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    List<Stub>? files,
    Stub? selectedDir,
    Stub? selectedFile,
  }) {
    return HomeState(
      files: files ?? _value.files,
      selectedDir: selectedDir ?? _value.selectedDir,
      selectedFile: selectedFile ?? _value.selectedFile,
    );
  }

  HomeState files(List<Stub> files) => this(files: files);

  HomeState selectedDir(Stub selectedDir) => this(selectedDir: selectedDir);

  HomeState selectedFile(Stub selectedFile) => this(selectedFile: selectedFile);
}

extension HomeStateCopyWith on HomeState {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass HomeState extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass HomeState extends Equatable.name.copyWith.fieldName(...)`
  _HomeStateCWProxy get copyWith => _HomeStateCWProxy(this);
}
