import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:blood_71/src/controllers/url_constants.dart';
import 'package:blood_71/src/pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late AnimationController _animationController;
  // ignore: unused_field
  late Animation _animation;
  late final TextEditingController _emailController = TextEditingController(text: '');
  late final TextEditingController _passwordController =
  TextEditingController(text: '');
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: _size.height/40, horizontal: _size.width/25),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(_size.width / 10),
              child: Image.asset(
                'assets/images/banner.png',
                width: _size.width,
                height: _size.height/6,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please Enter Valid Email';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.red),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
                hintText: 'm.....@..com',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Please don\'t enter getter than 6';
                } else {
                  return null;
                }
              },
              style: const TextStyle(color: Colors.red),
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: 'password',
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _obscureText = !_obscureText;
                    },
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.red,
                    ),
                  )),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 40),
            MaterialButton(
              onPressed: (){
                checkAuthentication();
              },
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
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
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
                  text: 'Don\'t have account?  ',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                TextSpan(
                  text: ' Register',
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkAuthentication() async {
    Map loginInfo = {
      "email" : _emailController.text,
      "password" : _passwordController.text
    };

    var url = Uri.parse(UrlConstants.loginAttemptUrl);
    /**
     * To show loading indicator until getting
     * any response from the api.
     */
    EasyLoading.show(
      status: 'Please Wait..',
    );
    var response = await http.post(url, body: loginInfo);
    var userInfo = jsonDecode(response.body);


    if(userInfo["status"] != "error"){
      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userInfo: userInfo),
        ),
      );
      return CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Login Success',
        text: 'WelCome, ${userInfo["name"]}',
      );
    }
    else{
      EasyLoading.dismiss();
      return CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Invalid Email/Password',
        text: 'Please try Again..',
        loopAnimation: false,
        backgroundColor: Colors.white
      );
    }
  }
}
