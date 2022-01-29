import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/layout_widget.dart';
import 'package:flutter/material.dart';

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
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71'),
        backgroundColor: Colors.green,
      ),
      body: LayoutWidget(
        children: [
          Row(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo/dummy.png',
                  height: (_size.height/4),
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                child: Text('Blood Ekattor', style: TextStyle(
                  fontFamily: 'Roboto',
                ),),
              )
            ],
          ),
        ],
      ),
    );
  }
}
