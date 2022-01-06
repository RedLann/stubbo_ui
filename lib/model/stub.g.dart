// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stub.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfStub.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfStub.copyWith.fieldName(...)`
class _StubCWProxy {
  final Stub _value;

  const _StubCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `Stub(...).copyWithNull(...)` to set certain fields to `null`. Prefer `Stub(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Stub(...).copyWith(id: 12, name: "My name")
  /// ````
  Stub call({
    List<Stub>? children,
    bool? isDir,
    String? mimeType,
    String? name,
    String? path,
    int? timestamp,
  }) {
    return Stub(
      children: children ?? _value.children,
      isDir: isDir ?? _value.isDir,
      mimeType: mimeType ?? _value.mimeType,
      name: name ?? _value.name,
      path: path ?? _value.path,
      timestamp: timestamp ?? _value.timestamp,
    );
  }

  Stub mimeType(String? mimeType) => mimeType == null
      ? _value._copyWithNull(mimeType: true)
      : this(mimeType: mimeType);

  Stub children(List<Stub> children) => this(children: children);

  Stub isDir(bool isDir) => this(isDir: isDir);

  Stub name(String name) => this(name: name);

  Stub path(String path) => this(path: path);

  Stub timestamp(int timestamp) => this(timestamp: timestamp);
}

extension StubCopyWith on Stub {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass Stub.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass Stub.name.copyWith.fieldName(...)`
  _StubCWProxy get copyWith => _StubCWProxy(this);

  Stub _copyWithNull({
    bool mimeType = false,
  }) {
    return Stub(
      children: children,
      isDir: isDir,
      mimeType: mimeType == true ? null : this.mimeType,
      name: name,
      path: path,
      timestamp: timestamp,
    );
  }
}

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfStubUiModel.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfStubUiModel.copyWith.fieldName(...)`
class _StubUiModelCWProxy {
  final StubUiModel _value;

  const _StubUiModelCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `StubUiModel(...).copyWithNull(...)` to set certain fields to `null`. Prefer `StubUiModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StubUiModel(...).copyWith(id: 12, name: "My name")
  /// ````
  StubUiModel call({
    List<Stub>? children,
    bool? isDir,
    int? level,
    String? mimeType,
    String? name,
    String? path,
  }) {
    return StubUiModel(
      children: children ?? _value.children,
      isDir: isDir ?? _value.isDir,
      level: level ?? _value.level,
      mimeType: mimeType ?? _value.mimeType,
      name: name ?? _value.name,
      path: path ?? _value.path,
    );
  }

  StubUiModel mimeType(String? mimeType) => mimeType == null
      ? _value._copyWithNull(mimeType: true)
      : this(mimeType: mimeType);

  StubUiModel children(List<Stub> children) => this(children: children);

  StubUiModel isDir(bool isDir) => this(isDir: isDir);

  StubUiModel level(int level) => this(level: level);

  StubUiModel name(String name) => this(name: name);

  StubUiModel path(String path) => this(path: path);
}

extension StubUiModelCopyWith on StubUiModel {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass StubUiModel extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass StubUiModel extends Equatable.name.copyWith.fieldName(...)`
  _StubUiModelCWProxy get copyWith => _StubUiModelCWProxy(this);

  StubUiModel _copyWithNull({
    bool mimeType = false,
  }) {
    return StubUiModel(
      children: children,
      isDir: isDir,
      level: level,
      mimeType: mimeType == true ? null : this.mimeType,
      name: name,
      path: path,
    );
  }
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StubAdapter extends TypeAdapter<Stub> {
  @override
  final int typeId = 0;

  @override
  Stub read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stub(
      name: fields[0] as String,
      path: fields[1] as String,
      mimeType: fields[2] as String?,
      isDir: fields[3] as bool,
      children: (fields[4] as List).cast<Stub>(),
      timestamp: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Stub obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.mimeType)
      ..writeByte(3)
      ..write(obj.isDir)
      ..writeByte(4)
      ..write(obj.children)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StubAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stub _$StubFromJson(Map<String, dynamic> json) => Stub(
      name: json['name'] as String,
      path: json['path'] as String,
      mimeType: json['mimeType'] as String?,
      isDir: json['isDir'] as bool,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Stub.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      timestamp: json['timestamp'] as int? ?? 0,
    );

Map<String, dynamic> _$StubToJson(Stub instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'mimeType': instance.mimeType,
      'isDir': instance.isDir,
      'children': instance.children,
      'timestamp': instance.timestamp,
    };
