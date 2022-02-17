import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('Update Blood Donation Information...')
        ],
      ),
      bottomNavigationBar: CustomBottomNav(pageNo: 3,),
    );
  }
}
