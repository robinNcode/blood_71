import 'package:blood_71/src/pages/home_page.dart';
import 'package:blood_71/src/theme/loading_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      'home': (_) => const HomePage(),
      'initial' : (_) => const LoadingPage(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
