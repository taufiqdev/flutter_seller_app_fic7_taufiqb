//import 'dart:html';

import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../common/global_variable.dart';
import 'package:http/http.dart' as http;

import '../models/categories_response_model.dart';
import 'auth_local_datasource.dart';

class CategoryRemoteDatasource {
  Future<Either<String, CategoriesResponseModel>> getCategories() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/categories'),
        headers: headers);
    if (response.statusCode == 200) {
      return Right(CategoriesResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
