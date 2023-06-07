import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view-model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _myRepo = AuthRepository();
  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      log(value.toString());
      await UserViewModel().saveUser(UserModel.fromJson(value));
      Utils.flushBarErrorMessage('Login success', context);

      Navigator.of(context).pushReplacementNamed(RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      log(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.signUpApi(data).then((value) {
      setLoading(false);
      log(value.toString());
      Utils.flushBarErrorMessage('signUp success', context);
      Navigator.of(context).pushReplacementNamed(RoutesName.login);
    }).onError((error, stackTrace) {
      setLoading(false);
      log(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
