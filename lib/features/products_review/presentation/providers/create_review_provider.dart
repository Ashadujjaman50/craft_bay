import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/create_review_params.dart';

class CreateReviewProvider extends ChangeNotifier {
  bool _reviewInProgress = false;

  bool get reviewInProgress => _reviewInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addNewReview(CreateReviewParams params) async {
    bool isSuccess = false;
    _reviewInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addReviewUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _reviewInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}