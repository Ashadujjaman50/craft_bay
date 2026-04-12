import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class ProductFavouriteButton extends StatelessWidget {
  const ProductFavouriteButton({
    super.key, required this.onTapAddWishList,
  });

  final VoidCallback onTapAddWishList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAddWishList,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(
          Icons.favorite_outline,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
