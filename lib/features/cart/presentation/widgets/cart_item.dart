import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../../shared/presentation/widgets/network_image_widget.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/cart_item_model.dart';
import '../providers/cart_list_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(30),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppNetworkImage(
                urls: cartItemModel.productModel.photos,
                height: 90,
                width: 90,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItemModel.productModel.title,
                              style: context.textTheme.titleMedium,
                            ),
                            if (cartItemModel.color != null || cartItemModel.size != null)
                              Text(
                                '${cartItemModel.color != null ? 'Color: ${cartItemModel.color}  ' : ''}${cartItemModel.size != null ? 'Size: ${cartItemModel.size}' : ''}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                          ],
                        ),
                      ),
                      //delete add to cart item
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) { 
                              return AlertDialog(
                                title: const Text('Delete Cart Item'),
                                content: const Text('Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(dialogContext);
                                      final isSuccess = await context.read<CartListProvider>().deleteCartItem(cartItemModel.id);
                                      
                                      if (isSuccess) {
                                        if (context.mounted) {
                                          showSnackBarMessage(context, 'Removed from cart');
                                        }
                                      } else {
                                        if (context.mounted) {
                                          final errorMessage = context.read<CartListProvider>().errorMessage;
                                          showSnackBarMessage(
                                            context,
                                            errorMessage ?? 'Failed to remove'
                                          );
                                        }
                                      }
                                    },
                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}${cartItemModel.productModel.currentPrice}',
                        style: const TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IncDecButton(
                        initialValue: cartItemModel.quantity,
                        maxCount: cartItemModel.productModel.quantity,
                        onChange: (int value) {
                          context.read<CartListProvider>().addQuantity(
                            cartItemModel.id,
                            value,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
