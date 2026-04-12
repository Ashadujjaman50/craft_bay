import 'package:craft_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../providers/wish_list_provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  static const String name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishListProvider>().getWishList();
    });
  }
  
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
        body: Consumer<WishListProvider>(
          builder: (context, wishListProvider, _) {
            
            if(wishListProvider.getWishListInProgress){
              return CenterCircularProgress();
            }

            if (wishListProvider.wishListItems.isEmpty) {
              return const Center(
                child: Text('No wish list items found'),
              );
            }
            
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: wishListProvider.wishListItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: ProductCard(
                      productModel: wishListProvider.wishListItems[index].productModel,
                      isWishListScreen: true,
                    ),
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }

  void _onTapBackButton(){
    context.read<MainNavProvider>().backToHome();
  }
}
