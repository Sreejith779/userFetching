import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

import '../models.dart';
import 'package:flutter/services.dart' as rootBundle;
class DataServices{

  Future<List<UserModel>>ReadJsonData()async{
    final response = rootBundle.rootBundle.loadString('jsonfile/data.json');
    final list = json.decode(response as String) as List<dynamic>;

    return list.map((e) => UserModel.fromJson(e)).toList();
  }
}