import 'package:flutter/material.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInProgress = false;

  bool get signInProgress => _signInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn({required String email,required String password}) async {
    bool isSuccess = false;
    _signInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.isSuccess) {
      //User Model Save
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);
      String token = response.body['data']['token'];

      await AuthController.saveUserData(token, userModel);

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _signInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}