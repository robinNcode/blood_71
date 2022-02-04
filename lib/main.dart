import 'package:blood_71/src/theme/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Ekattor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //initialRoute: 'initial',
      routes: Routes.getRoute(),
      home: const LoadingPage(),
    );
  }
}
