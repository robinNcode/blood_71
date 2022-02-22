import 'dart:convert';

import 'package:blood_71/src/controllers/url_constants.dart';
import 'package:blood_71/src/models/blood_group_model.dart';
import 'package:blood_71/src/theme/bottom_navigation_bar.dart';
import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BloodRequestPage extends StatefulWidget {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  _BloodRequestPageState createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _bloodGroup =
      TextEditingController(text: '');
  late final TextEditingController _thana =
      TextEditingController(text: '');
  late final TextEditingController _date =
      TextEditingController(text: '');
  late  TextEditingController _time =
      TextEditingController(text: '');
  late final TextEditingController _hospitalName =
      TextEditingController(text: '');
  late final TextEditingController _hospitalAddress =
      TextEditingController(text: '');
  late final TextEditingController _reason =
      TextEditingController(text: '');
  late final TextEditingController _patientName =
      TextEditingController(text: '');
  late final TextEditingController _contactPersonPhone =
      TextEditingController(text: '');

  static final List<String> items = BloodGroupModel.findAll();
  final _bloodRequestFormKey = GlobalKey<FormState>();

  final FocusNode _bloodGroupFocusNode = FocusNode();
  final FocusNode _thanaFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _hospitalNameFocusNode = FocusNode();
  final FocusNode _hospitalAddressFocusNode = FocusNode();
  final FocusNode _reasonFocusNode = FocusNode();
  final FocusNode _contactPersonNameFocusNode = FocusNode();
  final FocusNode _contactPersonPhoneFocusNode = FocusNode();

  @override
  void dispose() {
    _bloodGroup.dispose();
    _thana.dispose();
    _date.dispose();
    _time.dispose();
    _hospitalName.dispose();
    _hospitalAddress.dispose();
    _reason.dispose();
    _patientName.dispose();
    _contactPersonPhone.dispose();

    super.dispose();
  }

  Future<void> _submitFormRegister() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    final isValid = _bloodRequestFormKey.currentState!.validate();
    if (isValid == true && userId != null) {
      Map bloodRequestInfo = {
        "user_id": "$userId",
        "blood_group": bloodGroup,
        "thana": _thana.text,
        "time" : _time,
        "date" : _date,
        "hospital_name": _hospitalName.text,
        "hospital_address": _hospitalAddress.text,
        "reason": _reason.text,
        "contact_person_name" : _patientName.text,
        "contact_person_phone" : _contactPersonPhone.text,
      };

      var url = Uri.parse(UrlConstants.bloodRequest);
      /**
       * To show loading indicator until getting
       * any response from the api.
       */
      EasyLoading.show(
        status: 'Requesting..!',
      );
      var response = await http.post(url, body: bloodRequestInfo);
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
                key: _bloodRequestFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeader(customIcon: Icons.maps_ugc_sharp,header: 'Request For Blood'),
                    const Divider(),
                    //Blood group section...
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

                    //Thana section ...
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_thanaFocusNode),
                      focusNode: _thanaFocusNode,
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

                    TextButton(
                        onPressed: () {
                          DatePicker.showTime12hPicker(context, showTitleActions: true,
                              onChanged: (date) {

                              }, onConfirm: (date) {
                                _time = date as TextEditingController;
                              }, currentTime: DateTime.now()

                          );

                        },
                        child: const Text('Time')
                    ),

                    TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2019, 6, 7),
                              theme: const DatePickerTheme(
                                  headerColor: Colors.orange,
                                  backgroundColor: Colors.blue,
                                  itemStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                              onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              }, onConfirm: (date) {
                                print('confirm $date');
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        child: const Text(
                          'show date picker(custom theme &date time range)',
                          style: TextStyle(color: Colors.blue),
                        )),

                    const CustomHeader(header: "Hospital information", customIcon: Icons.home),
                    const Divider(),
                    //Hospital Name section ...
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_hospitalNameFocusNode),
                      focusNode: _hospitalNameFocusNode,
                      controller: _hospitalName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Hospital Name is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Hospital Name',
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
                    //Hospital address section ...
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_hospitalAddressFocusNode),
                      focusNode: _hospitalAddressFocusNode,
                      controller: _hospitalAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Hospital Address',
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


                    const CustomHeader(header: "Contact Person information", customIcon: Icons.supervised_user_circle_outlined),
                    const Divider(),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_contactPersonNameFocusNode),
                      focusNode: _contactPersonNameFocusNode,
                      controller: _patientName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Contact Person is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Contact Person Name',
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
                          FocusScope.of(context).requestFocus(_contactPersonPhoneFocusNode),
                      focusNode: _contactPersonPhoneFocusNode,
                      controller: _contactPersonPhone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_size.width / 20),
                        labelText: 'Contact Number',
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
      bottomNavigationBar: CustomBottomNav(pageNo: 2),
    );
  }
}
