import 'package:flutter/material.dart';

import '../features/auth/presentation/screen/sign_in_screen.dart';
import '../features/auth/presentation/screen/sign_up_screen.dart';
import '../features/auth/presentation/screen/splash_screen.dart';
import '../features/auth/presentation/screen/verify_otp_screen.dart';
import '../features/category/data/models/category_model.dart';
import '../features/products_review/presentation/screen/create_review_screen.dart';
import '../features/products/presentation/screen/product_details_screen.dart';
import '../features/products/presentation/screen/product_list_screen.dart';
import '../features/products_review/presentation/screen/product_review_screen.dart';
import '../features/shared/presentation/screens/main_nav_holder_screen.dart';
import '../features/wishlist/presentation/screen/wish_list_screen.dart';

class AppRoutes{

  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();
    switch(settings.name){
      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case SignUpScreen.name:
        widget = const SignUpScreen();
        break;
      case SignInScreen.name:
        widget = const SignInScreen();
        break;
      case VerifyOtpScreen.name:
        final email = settings.arguments as String;
        widget = VerifyOtpScreen(email: email);
        break;
      case MainNavHolderScreen.name:
        widget = const MainNavHolderScreen();
        break;
      case ProductListScreen.name:
        final category = settings.arguments as CategoryModel;
        widget = ProductListScreen(category: category);
        break;
      case ProductDetailsScreen.name:
        final productId = settings.arguments as String;
        widget = ProductDetailsScreen(productId: productId);
        break;
      case ProductReviewScreen.name:
        final productId = settings.arguments as String;
        widget = ProductReviewScreen(productId: productId);
        break;
      case CreateReviewScreen.name:
        widget = const CreateReviewScreen();
        break;

    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}

//return MaterialPageRoute(builder: (context) => const SplashScreen());