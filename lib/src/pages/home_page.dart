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
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood 71'),
        backgroundColor: Colors.green,
      ),
      body: LayoutWidget(
        children: [
          Row(
            children: [
              Image.asset(
                'logo/dummy.png',
                height: (_size.height).h,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
