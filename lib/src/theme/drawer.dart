import 'package:blood_71/src/pages/home_page.dart';
import 'package:blood_71/src/pages/profile.dart';
import 'package:blood_71/src/theme/loading_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset('assets/images/banner.png'),
                  ),
                  //These can go here or below the header with the same background color
                  const Text("user name"),
                  //customize this text
                  const Text("useremail@example.com"),
                  //...additional header items here
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 25),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage(userInfo: null,))
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.home,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        Text(
                          '   Home',
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _size.height / 45,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.perm_contact_calendar_outlined,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                        Text(
                          '    Profile',
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _size.height / 45,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(
                          Icons.maps_ugc_sharp,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        Text(
                          '    Latest Request',
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _size.height / 45,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(
                          Icons.policy,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        Text(
                          '    Privacy Policy',
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: _size.height / 45,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingPage()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        Text(
                          '    Sign Out',
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
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
