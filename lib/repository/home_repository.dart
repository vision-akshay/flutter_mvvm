import 'dart:developer';

import 'package:flutter_mvvm/data/network/base_api_service.dart';
import 'package:flutter_mvvm/data/network/network_api_service.dart';
import 'package:flutter_mvvm/model/movies_list_model.dart';
import 'package:flutter_mvvm/res/app_url.dart';

class HomeRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<MoviesListModel> getMoviesList() async {
    log('api call---->${AppUrl.moviesListEndPoint}');
    try {
      dynamic response =
          await _apiService.getGetApiResponse(AppUrl.moviesListEndPoint);
      return MoviesListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
