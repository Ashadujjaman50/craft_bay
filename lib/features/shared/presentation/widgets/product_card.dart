import 'package:craft_bay/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../products/data/models/add_wish_list_model.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/providers/add_wish_list_provider.dart';
import '../../../products/presentation/screen/product_details_screen.dart';
import '../../../wishlist/presentation/screen/wish_list_screen.dart';
import 'network_image_widget.dart';
import 'product_favourite_button.dart';
import 'snack_bar_message.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel, this.isWishListScreen = false});

  final ProductModel productModel;
  final bool isWishListScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: AppColors.themeColor.withAlpha(50),
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Container(
                width: 140,
                height: 120,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(30),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: AppNetworkImage(urls: productModel.photos),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      productModel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${Constants.takaSign}${productModel.currentPrice}',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.star, size: 18, color: Colors.amber),
                            Text(
                              '4.6',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        //wishlist added
                        ProductFavouriteButton(
                          onTapAddWishList: () async {

                            if (isWishListScreen) {
                              final wishListProvider = context.read<WishListProvider>();
                              try {
                                final item = wishListProvider.wishListItems.firstWhere(
                                        (element) => element.productModel.id == productModel.id);

                                final isSuccess = await wishListProvider.deleteWishListItem(item.id);
                                if (isSuccess) {
                                  if (context.mounted) {
                                    showSnackBarMessage(context, 'Removed from wish list');
                                  }
                                } else {
                                  if (context.mounted) {
                                    showSnackBarMessage(
                                        context,
                                        wishListProvider.errorMessage ?? 'Failed to remove'
                                    );
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showSnackBarMessage(context, 'Item not found in wish list');
                                }
                              }
                            } else {
                              final addWishListProvider = context.read<AddWishListProvider>();
                              AddWishListModel params = AddWishListModel(
                                id: productModel.id,
                              );
                              final isSuccess = await addWishListProvider.addWishList(params);
                              if (isSuccess) {
                                if (context.mounted) {
                                  showSnackBarMessage(context, 'Added to wish list');
                                }
                              } else {
                                if (context.mounted) {
                                  showSnackBarMessage(
                                      context,
                                      addWishListProvider.errorMessage ?? 'Failed to add'
                                  );
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
