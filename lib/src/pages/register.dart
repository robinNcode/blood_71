import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blood_71/src/controllers/url_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cool_alert/cool_alert.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _emailController =
      TextEditingController(text: '');
  late final TextEditingController _passwordController =
      TextEditingController(text: '');
  late final TextEditingController _confirmPassController =
      TextEditingController(text: '');
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final _registerFormKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPassFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _submitFormRegister() async {

    if(_passwordController.text != _confirmPassController.text){
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error!',
          text: 'Password and Confirm password is not same',
          loopAnimation: false,
          backgroundColor: Colors.white
      );
    }

    final isValid = _registerFormKey.currentState!.validate();
    if(isValid == true){
      Map registerInfo = {
        "email" : _emailController.text,
        "password" : _passwordController.text
      };

      var url = Uri.parse(UrlConstants.registerUrl);
      var response = await http.post(url, body: registerInfo);
      var operation = jsonDecode(response.body);

      if(operation["status"] == "success"){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        return CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Success!',
          text: '${operation["message"]}',
        );
      }
      else {
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: 'Invalid Username/Password',
            text: '${operation["message"]}',
            loopAnimation: false,
            backgroundColor: Colors.white
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 40, horizontal: _size.width / 25),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(_size.width / 10),
              child: Image.asset(
                'assets/images/banner.png',
                width: _size.width,
                height: _size.height / 6,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: _size.height / 70),
            const Text(
              'Register',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_emailFocusNode),
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Enter Valid Email';
                      } else {
                        return null;
                      }
                    },
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
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    focusNode: _passwordFocusNode,
                    obscureText: _obscureText,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please Enter Valid Password';
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.red,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(_confirmPassFocusNode),
                    focusNode: _confirmPassFocusNode,
                    obscureText: _obscureTextConfirm,
                    controller: _confirmPassController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please Enter Valid Password';
                      }
                      else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextConfirm = !_obscureTextConfirm;
                          });
                        },
                        child: Icon(
                          _obscureTextConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.red,
                        ),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: const UnderlineInputBorder(
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
