import 'package:blood_71/src/pages/blood_request_page.dart';
import 'package:blood_71/src/pages/donate.dart';
import 'package:blood_71/src/pages/home_page.dart';
import 'package:blood_71/src/pages/profile.dart';
import 'package:blood_71/src/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNav  extends StatelessWidget {
  var pageNo;

  CustomBottomNav ({Key? key, required this.pageNo}) : super(key: key);

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List _pages = [
      const HomePage(userInfo: null),
      const SearchPage(),
      const BloodRequestPage(),
      const DonatePage(),
      const ProfilePage()
    ];
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: pageNo,
      height: 50.0,
      items: const <Widget>[
        Icon(Icons.home, size: 25, color: Colors.white,),
        Icon(Icons.search, size: 25, color: Colors.white,),
        Icon(Icons.maps_ugc_sharp, size: 25, color: Colors.white,),
        Icon(Icons.add, size: 25, color: Colors.white,),
        Icon(Icons.perm_identity, size: 25, color: Colors.white,),
      ],
      color: Colors.red,
      buttonBackgroundColor: Colors.red,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _pages[index])
        );
      },
      letIndexChange: (index) => true,
    );
  }
}

