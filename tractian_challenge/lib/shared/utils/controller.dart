import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tractian_challenge/shared/utils/model.dart';

abstract class Controller<E extends Model> {
  String buildJsonPath(final String directory);

  Future<String> getJson(final String path) async {
    return await rootBundle.loadString(path);
  }

  List<dynamic> parseJson(final String jsonString) {
    return jsonDecode(jsonString);
  }

  Future<List<dynamic>> getListJson({required String companyDirectory}) async {
    final String directory = buildJsonPath(companyDirectory);
    final String jsonString = await getJson(directory);
    final List<dynamic> json = parseJson(jsonString);
    return json;
  }

  Future<List<E>> getList({required String companyDirectory}) async {
    final List<dynamic> json =
        await getListJson(companyDirectory: companyDirectory);
    return json.map((map) => fromMap(map)).toList();
  }

  E fromMap(Map<String, dynamic> map);
}
