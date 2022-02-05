import 'dart:async';
import 'package:blood_71/src/pages/login.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>  with TickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);

    Timer(const Duration(seconds: 5), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: (){},
                      child: Image(
                        image: const AssetImage('assets/images/banner.png'),
                        width: MediaQuery.of(context).size.width/1.5,
                        height: MediaQuery.of(context).size.height/2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/3,
                  child: LinearProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Blood Ekattor',
                    color: Colors.black87,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('v1.0.0+1', style: TextStyle(fontSize: 22)),
                )
              ],
            ),
          ),
        )
    );
  }
}
