import 'package:blood_71/src/widgets/layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood 71'),
        backgroundColor: Colors.green,
      ),
      body: LayoutWidget(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 10.w,
                  child: Image.asset(
                    'logo/dummy.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const Text('Your Blood Can, \n Save Lives'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
