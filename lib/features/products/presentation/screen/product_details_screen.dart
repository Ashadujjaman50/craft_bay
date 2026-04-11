import 'package:craft_bay/features/products/presentation/screen/product_review_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../../shared/presentation/widgets/product_favourite_button.dart';
import '../../../shared/presentation/widgets/product_rating.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Product details')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                        children: [
                          _buildTitleSection(),
                          ColorPicker(
                            colors: ['Red', 'Black', 'White'],
                            onChange: (String color) {},
                          ),
                          const SizedBox(height: 16),
                          SizePicker(
                              sizes: ['S','M','L','XL','XXL'],
                              onChange: (String size){}
                          ),
                          const SizedBox(height: 16),
                          Text('Description', style: context.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('The govt. notes of Tk. 2 and Tk.5 have mostly been replaced by coins while lower denomination coins (including all poysha coins) up to Tk. 1 have almost gone out of circulation due to inflation. The most commonly used symbol for the taka is "৳" and "Tk", used on receipts while purchasing goods and services. It is divided into 100 poysha, but poysha coins are no longer in circulation.',
                          style: TextStyle(color: Colors.grey),
                          ),
              
                        ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PriceAndAddToCartSection(price: 120, onTapAddToCart: () {}),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Nike 2026- New Year Special Edition',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  ProductRating(rating: '4.8'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProductReviewScreen.name);
                    },
                    child: Text(
                      'Reviews',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ),
                  ProductFavouriteButton(),
                ],
              ),
            ],
          ),
        ),
        IncDecButton(onChange: (int count) {}),
      ],
    );
  }
}
