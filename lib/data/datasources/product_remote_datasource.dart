//import 'dart:html';

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_seller_app/data/models/products_response_model.dart';
import '../../common/global_variable.dart';
import '../models/auth_response_model.dart';
import '../models/request/login_request_model.dart';
import '../models/request/register_request_model.dart';
import 'package:http/http.dart' as http;

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final userId = await AuthLocalDatasource().getUserId();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/products?user_id=$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
