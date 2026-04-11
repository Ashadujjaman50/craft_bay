import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../../../shared/presentation/widgets/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  static const String name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,_){
        _onTapBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: _onTapBackButton,
              icon: Icon(Icons.arrow_back_ios)
          ),
          title: Text('Wish List'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 14,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return FittedBox(child: ProductCard());
            },
          ),
        ),
      ),
    );
  }

  void _onTapBackButton(){
    context.read<MainNavProvider>().backToHome();
  }
}
