import 'package:craft_bay/features/products/data/models/add_wish_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class AddWishListProvider extends ChangeNotifier {
  bool _addWishListInProgress = false;

  bool get getWishListInProgress => _addWishListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addWishList(AddWishListModel params) async {
    bool isSuccess = false;

    _addWishListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addWishListUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _addWishListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}