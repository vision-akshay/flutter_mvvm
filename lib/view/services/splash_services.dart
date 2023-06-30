import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view-model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) {
    getUserData().then((value) {
      log('token---->${value.token}');
      if (value.token == null || value.token == '' || value.token == 'null') {
        Navigator.of(context).pushReplacementNamed(RoutesName.login);
      } else {
        Navigator.of(context).pushReplacementNamed(RoutesName.home);
      }
    }).onError((error, stackTrace) {
      log('error--->$error');
    });
  }
}
