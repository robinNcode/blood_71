import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          /*AppBar(
              backgroundColor: Colors.white,
              leading: BackButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Menu',
                style: TextStyle(fontSize: 20, color: Colors.red),
              )),
           */
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 25),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          AssetImage('assets/images/logo.png'),

                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.red),
                        Text(
                          '  First Page',
                          style: TextStyle(color: Colors.red, fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.red),
                        Text(
                          '  Second Page',
                          style: TextStyle(color: Colors.red, fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.red),
                        Text(
                          '  Third Page',
                          style: TextStyle(color: Colors.red, fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}