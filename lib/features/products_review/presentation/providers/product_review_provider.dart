import 'package:craft_bay/features/products_review/data/models/review_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class ProductReviewProvider extends ChangeNotifier {

  List<ReviewModel> _reviewLists = [];

  bool _getProductReviewInProgress = false;

  bool get getProductReviewInProgress => _getProductReviewInProgress;

  List<ReviewModel> get reviewLists => _reviewLists;


  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductReview(String productId) async {
    bool isSuccess = false;

    _getProductReviewInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getReviewListUrl(productId),
    );
    if (response.isSuccess) {
      List<ReviewModel> reviewList = [];
      for (Map<String, dynamic> product in response.body['data']['results']) {
        reviewList.add(ReviewModel.fromJson(product));
      }
      _reviewLists = reviewList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProductReviewInProgress = false;
    notifyListeners();

    return isSuccess;
  }

}