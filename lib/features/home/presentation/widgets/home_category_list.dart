import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/providers/category_list_provider.dart';
import '../../../shared/presentation/widgets/category_card.dart';
import '../../../shared/presentation/widgets/center_circular_progress.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if (categoryListProvider.getInitialCategoryListInProgress) {
            return CenterCircularProgress();
          }

          return ListView.separated(
            scrollDirection: .horizontal,
            shrinkWrap: true,
            itemCount: getCategoryListLength(categoryListProvider.categories.length),
            itemBuilder: (context, index) => CategoryCard(
              categoryModel: categoryListProvider.categories[index],
            ),
            separatorBuilder: (_,_)=> const SizedBox(width: 8),
          );
        }
      ),
    );
  }

  int getCategoryListLength(int length) {
    return length > 10 ? 10 : length;
  }


}