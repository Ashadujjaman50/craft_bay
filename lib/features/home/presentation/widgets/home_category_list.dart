import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/category_card.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: .horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => CategoryCard(),
        separatorBuilder: (_,_)=> const SizedBox(width: 8),
      ),
    );
  }
}