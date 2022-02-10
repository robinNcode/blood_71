import 'package:blood_71/src/theme/drawer.dart';
import 'package:blood_71/src/widgets/blood_group_drop_down.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class BloodRequestPage extends StatefulWidget {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  _BloodRequestPageState createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _bloodGroupController =
      TextEditingController(text: '');
  late final TextEditingController _thanaController =
      TextEditingController(text: '');
  late final TextEditingController _dateController =
      TextEditingController(text: '');
  late final TextEditingController _timeController =
      TextEditingController(text: '');
  late final TextEditingController _hospitalNameController =
      TextEditingController(text: '');
  late final TextEditingController _hospitalAddressController =
      TextEditingController(text: '');
  late final TextEditingController _reasonController =
      TextEditingController(text: '');
  late final TextEditingController _contactPersonNameController =
      TextEditingController(text: '');
  late final TextEditingController _contactPersonPhoneController =
      TextEditingController(text: '');

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
    _bloodGroupController.dispose();
    _thanaController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _hospitalNameController.dispose();
    _hospitalAddressController.dispose();
    _reasonController.dispose();
    _contactPersonNameController.dispose();
    _contactPersonPhoneController.dispose();

    super.dispose();
  }

  void _submitFormRegister() {
    final isValid = _bloodRequestFormKey.currentState!.validate();
    if (kDebugMode) {
      print(';Invalid $isValid');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 40, horizontal: _size.width / 25),
        child: ListView(
          children: [
            const Text(
              'Request For Blood',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            Form(
              key: _bloodRequestFormKey,
              child: Column(
                children: [
                  const BloodGroupDropDown(
                    dropdownvalue: 'A+',
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_thanaFocusNode),
                    focusNode: _bloodGroupFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    controller: _bloodGroupController,
                    style: const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    onPressed: _submitFormRegister,
                    color: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Signup',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: _size.height / 40),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Already Have an Account?',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      const TextSpan(text: '    '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage())),
                        text: 'Login',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
