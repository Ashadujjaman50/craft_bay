import 'package:flutter/material.dart';

import '../features/auth/presentation/screen/sign_in_screen.dart';
import '../features/auth/presentation/screen/sign_up_screen.dart';
import '../features/auth/presentation/screen/splash_screen.dart';
import '../features/auth/presentation/screen/verify_otp_screen.dart';
import '../features/products/presentation/screen/create_review_screen.dart';
import '../features/products/presentation/screen/product_details_screen.dart';
import '../features/products/presentation/screen/product_list_screen.dart';
import '../features/products/presentation/screen/product_review_screen.dart';
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
        final categoryName = settings.arguments as String;
        widget = ProductListScreen(categoryName: categoryName);
        break;
      case ProductDetailsScreen.name:
        widget = const ProductDetailsScreen();
        break;
      case ProductReviewScreen.name:
        widget = const ProductReviewScreen();
        break;
      case CreateReviewScreen.name:
        widget = const CreateReviewScreen();
        break;

    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}

//return MaterialPageRoute(builder: (context) => const SplashScreen());