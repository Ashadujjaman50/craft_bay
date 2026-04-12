import 'package:craft_bay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:craft_bay/features/products/presentation/providers/product_list_provider.dart';
import 'package:craft_bay/features/products/presentation/providers/tag_product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../auth/presentation/screen/sign_in_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/providers/category_list_provider.dart';
import '../../../category/presentation/screens/category_list_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../wishlist/presentation/screen/wish_list_screen.dart';
import '../providers/main_nav_provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main-nav-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeSliderProvider>().getHomeSliders();
      context.read<CategoryListProvider>().getCategories();

      final tagProvider = context.read<TagProductListProvider>();
      tagProvider.getProducts('new');
      tagProvider.getProducts('popular');
      tagProvider.getProducts('special');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavProvider>(
      builder: (context, mainNavProvider, _) {
        return Scaffold(
          body: _screens[mainNavProvider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) async {
              if (mainNavProvider.shouldVerifyLoginState(index) &&
                  !(await mainNavProvider.isAlreadyLoggedIn())) {
                Navigator.pushNamed(context, SignInScreen.name);
                return;
              }

              mainNavProvider.changeIndex(index);
            },
            currentIndex: mainNavProvider.selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.themeColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            elevation: 3,

            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Wishlist',
              ),
            ],
          ),
          /*bottomNavigationBar: NavigationBar(
              onDestinationSelected: mainNavProvider.changeIndex,
              selectedIndex: mainNavProvider.selectedIndex,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.dashboard),
                  label: 'Categories',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_outline),
                  label: 'Wishlist',
                ),
              ],
          ),*/
        );
      },
    );
  }
}
