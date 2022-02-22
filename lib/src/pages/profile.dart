import 'dart:convert';
import 'package:blood_71/src/controllers/url_constants.dart';
import 'package:blood_71/src/models/blood_group_model.dart';
import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/custom_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cool_alert/cool_alert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final List<String> items = BloodGroupModel.findAll();
  final _registerFormKey = GlobalKey<FormState>();

  late final TextEditingController _userId = TextEditingController(text: '');
  late final TextEditingController _name = TextEditingController(text: '');
  late final TextEditingController _phone = TextEditingController(text: '');
  late final TextEditingController _address = TextEditingController(text: '');
  late final TextEditingController _district = TextEditingController(text: '');
  late final TextEditingController _thana = TextEditingController(text: '');

  final FocusNode userFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode districtFocusNode = FocusNode();
  final FocusNode thanaFocusNode = FocusNode();

  @override
  void dispose() {
    _userId.dispose();
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _district.dispose();
    _thana.dispose();
    super.dispose();
  }

  Future<void> _submitFormRegister() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    final isValid = _registerFormKey.currentState!.validate();
    if (isValid == true) {
      Map userUpdateInfo = {
        "user_id": "$userId",
        "name": _name.text,
        "image": "assets/images/uploads/${_name.text}.jpg",
        "blood_group": bloodGroup,
        "phone": _phone.text,
        "address": _address.text,
        "district": _district.text,
        "thana": _thana.text
      };

      var url = Uri.parse(UrlConstants.updateProfile);
      /**
       * To show loading indicator until getting
       * any response from the api.
       */
      EasyLoading.show(
        status: 'Updating..!',
      );
      var response = await http.post(url, body: userUpdateInfo);
      var info = jsonDecode(response.body);
      EasyLoading.dismiss();

      if(info["status"] == 'success'){
        return CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Success!',
          text: info["message"],
        );
      }
      else{
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: 'Something went wrong',
            text: 'Please try Again..',
            loopAnimation: false,
            backgroundColor: Colors.white
        );
      }

    }
  }

  String bloodGroup = 'A+';

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71',
            style: TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.red),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.width / 40),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Form(
                key: _registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeader(customIcon: Icons.supervised_user_circle,header: 'Profile Information'),
                    const Divider(),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(nameFocusNode),
                      focusNode: nameFocusNode,
                      controller: _name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full Name is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Full Name',
                        labelStyle: const TextStyle(color: Color(0xFF2E64A4)),
                        hintStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    DropdownButtonFormField(
                      value: bloodGroup,
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
                      onChanged: (String? value) {
                        bloodGroup = value!;
                      },
                      hint: const Text('Select a Blood Group'),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    const CustomHeader(customIcon: Icons.phone_android,header: 'Contact Information'),
                    const Divider(),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(phoneFocusNode),
                      focusNode: phoneFocusNode,
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Mobile/Phone Number',
                        labelStyle: const TextStyle(color: Color(0xFF2E64A4)),
                        hintStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    const CustomHeader(customIcon: Icons.home,header: 'Address Information'),
                    const Divider(),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(addressFocusNode),
                      focusNode: addressFocusNode,
                      controller: _address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Address',
                        labelStyle: const TextStyle(color: Color(0xFF2E64A4)),
                        hintStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(thanaFocusNode),
                      focusNode: thanaFocusNode,
                      controller: _thana,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Thana is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Thana/Upazila',
                        labelStyle: const TextStyle(color: Color(0xFF2E64A4)),
                        hintStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(districtFocusNode),
                      focusNode: districtFocusNode,
                      controller: _district,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'District is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'District',
                        labelStyle: const TextStyle(color: Color(0xFF2E64A4)),
                        hintStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF2E64A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                    Center(
                      child: SizedBox(
                          width: 130,
                          height: 50,
                          child: MaterialButton(
                            onPressed: _submitFormRegister,
                            color: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(pageNo: 4),
    );
  }
}
