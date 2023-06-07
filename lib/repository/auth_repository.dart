import 'dart:developer';

import 'package:flutter_mvvm/data/network/base_api_service.dart';
import 'package:flutter_mvvm/data/network/network_api_service.dart';
import 'package:flutter_mvvm/res/app_url.dart';

class AuthRepository {
  BaseApiService _apiServices = NetworkApiService();
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    log('url--->${AppUrl.registerApiEndPoint}');

    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
