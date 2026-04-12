import 'package:craft_bay/features/wishlist/data/models/wishlist_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';


class WishListProvider extends ChangeNotifier {

  List<WishlistItemModel> _wishListItems = [];
  bool _getWishListInProgress = true;
  bool _deleteWishListInProgress = false;

  bool get getWishListInProgress => _getWishListInProgress;
  bool get deleteWishListInProgress => _deleteWishListInProgress;

  List<WishlistItemModel> get wishListItems => _wishListItems;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _getWishListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getWishListUrl,
    );
    if (response.isSuccess) {
      List<WishlistItemModel> wishList = [];
      for (Map<String, dynamic> product in response.body['data']['results']) {
        wishList.add(WishlistItemModel.fromJson(product));
      }
      _wishListItems = wishList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getWishListInProgress = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> deleteWishListItem(String itemId) async {
    bool isSuccess = false;
    _deleteWishListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().deleteRequest(
      Urls.deleteWishListUrl(itemId),
    );

    if (response.isSuccess) {
      _wishListItems.removeWhere((item) => item.id == itemId);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _deleteWishListInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
