import 'dart:convert';
import 'package:blood_71/src/controllers/url_constants.dart';
import 'package:blood_71/src/models/blood_group_model.dart';
import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/custom_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final List<String> items = BloodGroupModel.findAll();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _size.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _size.height / 30,
                ),
                const Text(
                  'Update your profile Information',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(
                  height: _size.height / 30,
                ),
                const CustomField(labelText: 'Full name', labelColor: Color(0xFF2E64A4), hintText: 'Blood Ekattor',),
                SizedBox(
                  height: _size.height / 40,
                ),
                DropdownButtonFormField(
                  value: 'A+',
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Blood Group',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  onChanged: (String? value) {},
                ),
                SizedBox(
                  height: _size.height / 40,
                ),
                const Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(
                  height: _size.height / 30,
                ),
                const Divider(height: 3,),
                const CustomField(labelText: 'Mobile Number / Phone', labelColor: Color(0xFF2E64A4), hintText: '01...',),
                SizedBox(
                  height: _size.height / 40,
                ),
                const CustomField(labelText: 'Mobile Number', labelColor: Color(0xFF2E64A4), hintText: '',),
                SizedBox(
                  height: _size.height / 30,
                ),
                Column(
                  children: [
                    Row(children: <Widget>[
                      Expanded(
                        child: Container(
                            margin:
                            const EdgeInsets.only(left: 8, right: 8),
                            child: const Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                      const Text("OR", style: TextStyle(fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            child: const Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                    ]),
                  ],
                ),
                SizedBox(
                  height: _size.height / 40,
                ),
                const CustomField(labelText: 'Email', labelColor: Color(0xFF2E64A4), hintText: '',),
                SizedBox(
                  height: _size.height / 8,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: _size.height / 20),
                        child: const Text(
                          'For any help',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: _size.height / 60),
                        child: const Text(
                          'Call at 16479',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.done, color: Colors.white,),
      ),
      bottomNavigationBar: CustomBottomNav(pageNo: 4,),
    );
  }

}


