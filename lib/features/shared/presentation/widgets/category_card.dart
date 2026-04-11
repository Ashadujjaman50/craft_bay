import 'package:craft_bay/features/products/presentation/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../category/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});

  final CategoryModel categoryModel;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            ProductListScreen.name,
            arguments: categoryModel.title,
        );
      },
      child: Column(
        crossAxisAlignment: .center,
        spacing: 4,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              categoryModel.icon,
              width: 48,
              height: 48,
              errorBuilder: (context, child, loadingProgress)=> Icon(Icons.error_outline),
            ),
          ),
          Text(
            categoryModel.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w600,
              color: AppColors.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}