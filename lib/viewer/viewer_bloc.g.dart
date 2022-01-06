// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfViewerState.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfViewerState.copyWith.fieldName(...)`
class _ViewerStateCWProxy {
  final ViewerState _value;

  const _ViewerStateCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `ViewerState(...).copyWithNull(...)` to set certain fields to `null`. Prefer `ViewerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ViewerState(...).copyWith(id: 12, name: "My name")
  /// ````
  ViewerState call({
    Stub? current,
  }) {
    return ViewerState(
      current: current ?? _value.current,
    );
  }

  ViewerState current(Stub? current) => current == null
      ? _value._copyWithNull(current: true)
      : this(current: current);
}

extension ViewerStateCopyWith on ViewerState {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass ViewerState extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass ViewerState extends Equatable.name.copyWith.fieldName(...)`
  _ViewerStateCWProxy get copyWith => _ViewerStateCWProxy(this);

  ViewerState _copyWithNull({
    bool current = false,
  }) {
    return ViewerState(
      current: current == true ? null : this.current,
    );
  }
}
