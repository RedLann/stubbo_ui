import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'stub.g.dart';

@JsonSerializable()
@CopyWith()
@HiveType(typeId: 0)
class Stub extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String path;
  @HiveField(2)
  final String? mimeType;
  @HiveField(3)
  final bool isDir;
  @JsonKey(name: "children", defaultValue: [])
  @HiveField(4)
  final List<Stub> children;
  @HiveField(5)
  @JsonKey(name: "timestamp", defaultValue: 0)
  final int timestamp;

  static currentTimeStamp() => DateTime.now().millisecondsSinceEpoch;

  Stub(
      {required this.name,
      required this.path,
      required this.mimeType,
      required this.isDir,
      required this.children,
      this.timestamp = 0});

  const Stub.root(this.children)
      : name = "",
        path = "",
        mimeType = null,
        isDir = false,
        timestamp = 0;

  factory Stub.fromJson(Map<String, dynamic> json) => _$StubFromJson(json);

  Map<String, dynamic> toJson() => _$StubToJson(this);

  @override
  List<Object?> get props => [
    name,
    path,
    mimeType,
    isDir,
    children,
    timestamp,
  ];
}

@CopyWith()
class StubUiModel extends Equatable {
  final String name;
  final String path;
  final String? mimeType;
  final bool isDir;
  @JsonKey(name: "children", defaultValue: [])
  final List<Stub> children;
  final int level;

  const StubUiModel({
    required this.name,
    required this.path,
    required this.isDir,
    required this.children,
    required this.level,
    this.mimeType,
  });

  @override
  List<Object?> get props => [
        name,
        path,
        mimeType,
        isDir,
        children,
        level,
      ];
}
