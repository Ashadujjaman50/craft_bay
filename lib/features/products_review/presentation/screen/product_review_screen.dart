import 'package:craft_bay/features/products_review/presentation/screen/create_review_screen.dart';
import 'package:craft_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../providers/product_review_provider.dart';
import '../widgets/review_card.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key, required this.productId});

  static const String name = '/product-review';
  final String productId;

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {

  final ProductReviewProvider _productReviewProvider = ProductReviewProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _productReviewProvider.getProductReview(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: ChangeNotifierProvider.value(
        value: _productReviewProvider,
        child: Consumer<ProductReviewProvider>(
          builder: (context,_,_) {

            if (_productReviewProvider.getProductReviewInProgress) {
              return CenterCircularProgress();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _productReviewProvider.reviewLists.length,
                    padding: const EdgeInsets.only(top: 8),
                    itemBuilder: (context, index) {
                      return ReviewCard(
                        reviewModel: _productReviewProvider.reviewLists[index],
                      );
                    },
                  ),
                ),

                _buildReviewCountAndCreate('153', () {
                  Navigator.pushNamed(context, CreateReviewScreen.name);
                }),
              ],
            );
          }
        ),
      ),

    );
  }

  Widget _buildReviewCountAndCreate(String reviewCount, VoidCallback onTapCreate) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.themeColor.withAlpha(30),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews (${reviewCount})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              FloatingActionButton(
                onPressed: onTapCreate,
                backgroundColor: AppColors.themeColor,
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ],
          ),
        );
  }
}
