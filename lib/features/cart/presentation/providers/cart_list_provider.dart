import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/cart_item_model.dart';

class CartListProvider extends ChangeNotifier {
  List<CartItemModel> _cartItems = [];

  bool _getCartListInProgress = true;
  bool _deleteCartListInProgress = false;

  bool get getCartListInProgress => _getCartListInProgress;
  bool get deleteCartListInProgress => _deleteCartListInProgress;

  List<CartItemModel> get cartItems => _cartItems;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;

    _getCartListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getCartListUrl,
    );
    if (response.isSuccess) {
      List<CartItemModel> cartList = [];
      for (Map<String, dynamic> product in response.body['data']['results']) {
        cartList.add(CartItemModel.fromJson(product));
      }
      _cartItems = cartList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> deleteCartItem(String itemId) async {
    bool isSuccess = false;
    _deleteCartListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().deleteRequest(
      Urls.deleteCartListUrl(itemId),
    );
    if (response.isSuccess){
      _cartItems.removeWhere((item) => item.id == itemId);
      isSuccess = true;
      _errorMessage = null;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _deleteCartListInProgress = false;
    notifyListeners();
    return isSuccess;
  }


  int get totalCartItems => _cartItems.length;

  double get totalPrice {
    double totalPrice = 0;
    for (CartItemModel cartItem in _cartItems) {
      totalPrice += (cartItem.productModel.currentPrice * cartItem.quantity);
    }
    return totalPrice;
  }

  void addQuantity(String cartItemId, int quantity) {
    for (CartItemModel cartItem in _cartItems) {
      if (cartItem.id == cartItemId) {
        cartItem.quantity = quantity;
        notifyListeners();
        break;
      }
    }
  }
}