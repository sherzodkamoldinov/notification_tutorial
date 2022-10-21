import 'package:flutter/material.dart';
import 'package:notification_tutorial/ui/home_page/home_page.dart';
import 'package:notification_tutorial/ui/splash_screen/splash_page.dart';
import 'package:notification_tutorial/utils/consts.dart';

class MyGenerateRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return _navigateTo(const SplashPage());
      case mainPage:
        return _navigateTo(const HomePage());
      default:
        return _navigateTo(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}


 MaterialPageRoute _navigateTo(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }