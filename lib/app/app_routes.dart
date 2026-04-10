import 'package:flutter/material.dart';

import '../features/auth/presentation/screen/sign_up_screen.dart';
import '../features/auth/presentation/screen/splash_screen.dart';

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


    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}

//return MaterialPageRoute(builder: (context) => const SplashScreen());