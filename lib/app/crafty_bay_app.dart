import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/category/presentation/providers/category_list_provider.dart';
import '../features/home/presentation/providers/home_slider_provider.dart';
import '../features/products/presentation/providers/add_to_cart_provider.dart';
import '../features/products/presentation/providers/add_wish_list_provider.dart';
import '../features/products/presentation/providers/product_list_provider.dart';
import '../features/products/presentation/providers/tag_product_list_provider.dart';
import '../features/products_review/presentation/providers/product_review_provider.dart';
import '../features/shared/presentation/providers/main_nav_provider.dart';
import '../features/wishlist/presentation/providers/wish_list_provider.dart';
import '../l10n/app_localizations.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MainNavProvider()),
        ChangeNotifierProvider(create: (context) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),
        ChangeNotifierProvider(create: (context) => ProductListProvider()),
        ChangeNotifierProvider(create: (context) => TagProductListProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => AddWishListProvider()),
        ChangeNotifierProvider(create: (context) => AddToCartProvider()),
        ChangeNotifierProvider(create: (context) => ProductReviewProvider()),
      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            debugShowCheckedModeBanner: false,

            locale: languageProvider.currentLocale,
            supportedLocales: languageProvider.supportedLocales,

          );
        }
      ),
    );
  }
}
