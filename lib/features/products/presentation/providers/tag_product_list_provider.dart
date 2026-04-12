import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/product_model.dart';

class TagProductListProvider extends ChangeNotifier {

  final Map<String, List<ProductModel>> _tagProducts = {};
  final Map<String, bool> _loadingStates = {};
  final Map<String, String?> _errorMessages = {};

  bool isLoading(String tag) => _loadingStates[tag] ?? false;
  List<ProductModel> getProductsByTag(String tag) => _tagProducts[tag] ?? [];
  String? getErrorMessage(String tag) => _errorMessages[tag];

  Future<bool> getProducts(String tag) async {
    _loadingStates[tag] = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.tagProductListUrl(tag),
    );

    if (response.isSuccess) {
      List<ProductModel> productList = [];
      for (Map<String, dynamic> product in response.body['data']['results']) {
        productList.add(ProductModel.fromJson(product));
      }

      _tagProducts[tag] = productList;
      _errorMessages[tag] = null;
    } else {
      _errorMessages[tag] = response.errorMessage;
    }

    _loadingStates[tag] = false;
    notifyListeners();
    return response.isSuccess;
  }
}
