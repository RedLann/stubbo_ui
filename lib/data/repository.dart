import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:stubbo_ui/constants.dart';
import 'package:stubbo_ui/data/local_datasource.dart';
import 'package:stubbo_ui/di/injection.dart';
import 'package:stubbo_ui/home/home_bloc.dart';
import 'package:stubbo_ui/model/stub.dart';

class DataError extends Equatable implements Exception {
  final int code;
  final String message;
  final String url;

  const DataError(this.code, this.message, this.url);

  @override
  List<Object?> get props => [code, message, url];
}

enum HttpMethod { PATCH, PUT, DELETE, GET }

class Repository {
  final baseurl = injector.get<String>(instanceName: "baseurl");
  final ld = injector.get<LocalDatasource>();

  Future<R> handleCall<R>(HttpMethod method, String url,
      {R Function(dynamic json)? converter,
      String body = "",
      bool encodeJson = false}) async {
    final http.Response response;
    switch (method) {
      case HttpMethod.PATCH:
        response = await http.patch(Uri.parse(url), body: body);
        break;
      case HttpMethod.PUT:
        response = await http.put(Uri.parse(url), body: body);
        break;
      case HttpMethod.DELETE:
        response = await http.delete(Uri.parse(url), body: body);
        break;
      case HttpMethod.GET:
        response = await http.get(Uri.parse(url));
        break;
    }
    if (response.statusCode == 200) {
      if (!encodeJson) {
        return response.body as R;
      } else {
        return converter!.call(jsonDecode(response.body));
      }
    } else {
      throw DataError(response.statusCode, response.body, url);
    }
  }

  Future<String> update(String path, bool isDir, {String body = ""}) async {
    final url = baseurl + "edit/$path?isDir=$isDir";
    return handleCall<String>(HttpMethod.PUT, url, body: body);
  }

  Future<String> rename(String path, String newPath) async {
    final url = baseurl + "edit/$path";
    return handleCall<String>(HttpMethod.PATCH, url, body: newPath);
  }

  Future<String> delete(String path) async {
    final url = baseurl + "edit/$path";
    return handleCall<String>(HttpMethod.DELETE, url);
  }

  // Future<List<Stub>> listDirs({String path = ""}) {
  //   final url = baseurl + "list/dirs/$path";
  //   return handleCall<List<Stub>>(HttpMethod.GET, url, converter: (json) {
  //     final iterable = json as Iterable;
  //     return List<Stub>.from(iterable.map((e) => Stub.fromJson(e)));
  //   }, encodeJson: true);
  // }

  Future<void> refreshPath(String path) async {
    final url = baseurl + "list/all/$path";
    final stub =
        await handleCall<Stub>(HttpMethod.GET, url, converter: (json) {
      return Stub.fromJson(json);
    }, encodeJson: true);
    return await ld.putStub(stub.copyWith(timestamp: Stub.currentTimeStamp()));
  }

  Stub? getStub(String path) {
    return ld.getStub(path);
  }

  ValueListenable<Box<Stub>> getListenable(String path) {
    if (!ld.isDataFresh(path)) {
      refreshPath(path);
    }
    return ld.listenable(path);
  }

  Future<Stub> listAll({String path = ""}) {
    final url = baseurl + "list/all/$path";
    return handleCall<Stub>(HttpMethod.GET, url, converter: (json) {
      return Stub.fromJson(json);
    }, encodeJson: true);
  }

  Future<void> upload(OnFileUpload data) async {
    var request = http.MultipartRequest("POST", Uri.parse(baseurl + "upload"));
    request.fields['filename'] = data.filename;
    request.fields['mimeType'] = data.mimeType;
    request.fields['parentPath'] = data.parentPath;
    request.files.add(http.MultipartFile.fromBytes('file', data.bytes));
    final response = await request.send();
    if (response.statusCode == 200) print("Uploaded!");
  }
}
