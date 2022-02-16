import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/layout_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final userInfo;
  const HomePage({Key? key, required this.userInfo}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final _height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final _width = MediaQuery.of(context).size.width;

    var _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71', style: TextStyle(color: Colors.red),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: LayoutWidget(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo/dummy.png',
                  height: (_size.height / 4),
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                child: Text(
                  'Blood Ekattor',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
