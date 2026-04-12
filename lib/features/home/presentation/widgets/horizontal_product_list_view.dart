import 'package:craft_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/presentation/providers/tag_product_list_provider.dart';
import '../../../shared/presentation/widgets/product_card.dart';

class HorizontalProductListView extends StatelessWidget {
  final String tag;

  const HorizontalProductListView({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TagProductListProvider>(
      builder: (context, tagProductListProvider, _) {
        final products = tagProductListProvider.getProductsByTag(tag);

        if (tagProductListProvider.isLoading(tag) && products.isEmpty) {
          return const CenterCircularProgress();
        }

        return SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getProductsListLength(products.length),
            itemBuilder: (context, index) {
              return ProductCard(productModel: products[index]);
            },
          ),
        );
      },
    );
  }

  int getProductsListLength(int length) {
    return length > 10 ? 10 : length;
  }
}
