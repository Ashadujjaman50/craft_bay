import 'package:craft_bay/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryName});

  final String categoryName;
  static const String name = '/product-list';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 13,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return FittedBox(child: ProductCard());
          },
        ),
      ),
    );
  }
}
