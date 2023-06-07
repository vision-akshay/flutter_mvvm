import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view-model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) {
    getUserData().then((value) {
      if (value.token == null || value.token == '') {
        Navigator.of(context).pushNamed(RoutesName.login);
      } else {
        Navigator.of(context).pushNamed(RoutesName.home);
      }
    }).onError((error, stackTrace) {
      log('error--->$error');
    });
  }
}
