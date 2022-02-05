import 'package:blood_71/src/pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/banner.png',
              width: _size.width,
              height: _size.height/6,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),
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
                labelStyle: TextStyle(color: Colors.red),
                hintStyle: TextStyle(color: Colors.red),
                hintText: 'm.....@..com',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow)),
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
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.red),
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.red),
                  hintStyle: const TextStyle(color: Colors.red),
                  hintText: 'password',
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen()));
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
                    SizedBox(width: 5),
                    Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
