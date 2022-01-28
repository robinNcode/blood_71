import 'package:blood_71/src/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      'home': (_) => const HomePage(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
