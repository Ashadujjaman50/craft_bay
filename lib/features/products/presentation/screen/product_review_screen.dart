import 'package:craft_bay/features/products/presentation/screen/create_review_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../widgets/review_card.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  static const String name = '/product-review';


  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4, 
              padding: const EdgeInsets.only(top: 8),
              itemBuilder: (context, index) {
                return const ReviewCard(
                  userName: 'Rabbil Hasan',
                  reviewText:
                  'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator',
                );
              },
            ),
          ),
         
          _buildReviewCountAndCreate('153', () {
            Navigator.pushNamed(context, CreateReviewScreen.name);
          }),
        ],
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
