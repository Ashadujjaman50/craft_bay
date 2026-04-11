import 'package:craft_bay/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';

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
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
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
