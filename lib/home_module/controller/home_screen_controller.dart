import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:two_hr_test/data/api_constants.dart';
import 'package:two_hr_test/data/image_model.dart';

class HomeScreenController extends GetxController {

  Dio dio = Dio();
  var salePageOffset = 0.obs;
  var salePageLimit = 10;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<ImageModel> imageList = RxList();

  @override
  void onInit() {
    super.onInit();
    getList();
  }




  Future<List<ImageModel>?> getList() async {
    try {
      Map<String, dynamic> queries = HashMap();
      final response = await dio.get(ApiConstants.productBaseUrl, queryParameters: queries);
      if (response.statusCode == 200) {
        imageList.value =
            (response.data as List).map((p) => ImageModel.fromJson(p)).toList();
        print(imageList.value);
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Error",));
      }
    } catch (e) {
      print(e);
    }
  }
}
