import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('Serach Here...')
        ],
      ),
      bottomNavigationBar: CustomBottomNav(pageNo: 1,),
    );
  }
}
