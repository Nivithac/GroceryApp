import 'dart:convert';
import 'package:flutter_application_1/model/drawer/productModel.dart';
import 'package:flutter_application_1/utils/api.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<dynamic> createProduct(ProductModelClass productModelClass) async {
    Map<String, dynamic> productData = {
      "name": productModelClass.name,
      "img": productModelClass.img,
      "category": productModelClass.category
    };

    // Simulate a network or database call
    print(
        'Creating product: ${productModelClass.name}, ${productModelClass.category}, ${productModelClass.img}');
    await Future.delayed(Duration(seconds: 1));

    try {
      var response = await http.post(
        //http://localhost:3000/category/create
        Uri.parse(Url.createProduct),

        body: jsonEncode(productData),
        headers: {"Content-Type": "application/json"},
      );
      print(Url.createProduct);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Product created successfully: $responseData");
        return responseData;
      } else {
        final responseData = jsonDecode(response.body);
        print("Failed to create product: ${responseData['message']}");
        throw Exception('Failed to create product: ${responseData['message']}');
      }
    } catch (e) {
      print("Product error: $e");
      throw Exception('Product: Failed to load API Data');
    }
  }
}
