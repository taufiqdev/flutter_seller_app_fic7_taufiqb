//import 'dart:html';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_seller_app/data/models/add_product_response_model.dart';
import 'package:flutter_seller_app/data/models/image_response_model.dart';
import 'package:flutter_seller_app/data/models/products_response_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/global_variable.dart';
import '../models/auth_response_model.dart';
import '../models/request/login_request_model.dart';
import '../models/request/product_request_model.dart';
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

  /* Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/products'),
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server error');
    }
  } */

  Future<Either<String, ImageResponseModel>> addImage(XFile image) async {
    //final userId = await AuthLocalDatasource().getUserId();
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('${GlobalVariables.baseUrl}'));

    final fileName = image.name;
    final bytes = await image.readAsBytes();

    final multiPartFile =
        http.MultipartFile.fromBytes('image', bytes, filename: fileName);

    request.files.add(multiPartFile);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 200) {
      return Right(ImageResponseModel.fromJson(responseData));
    } else {
      return Left('Server Error');
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel requestModel) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/products'),
        headers: headers,
        body: requestModel.toJson());
    if (response.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
